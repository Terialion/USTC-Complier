#include "CodeGen.hpp"

#include "CodeGenUtil.hpp"
#include <iostream>
#include <string>

void CodeGen::allocate() {
    // 备份 $ra $fp
    unsigned offset = PROLOGUE_OFFSET_BASE;

    // 为每个参数分配栈空间
    for (auto &arg : context.func->get_args()) {
        auto size = arg.get_type()->get_size();
        offset = offset + size;
        context.offset_map[&arg] = -static_cast<int>(offset);
    }

    // 为指令结果分配栈空间
    for (auto &bb : context.func->get_basic_blocks()) {
        for (auto &instr : bb.get_instructions()) {
            // 每个非 void 的定值都分配栈空间
            if (not instr.is_void()) {
                auto size = instr.get_type()->get_size();
                offset = offset + size;
                context.offset_map[&instr] = -static_cast<int>(offset);
            }
            // alloca 的副作用：分配额外空间
            if (instr.is_alloca()) {
                auto *alloca_inst = static_cast<AllocaInst *>(&instr);
                auto alloc_size = alloca_inst->get_alloca_type()->get_size();
                offset += alloc_size;
            }
        }
    }

    // 分配栈空间，需要是 16 的整数倍
    context.frame_size = ALIGN(offset, PROLOGUE_ALIGN);
}

void CodeGen::copy_stmt() {
    for (auto &succ : context.bb->get_succ_basic_blocks()) {
        for (auto &inst : succ->get_instructions()) {
            if (inst.is_phi()) {
                // 遍历后继块中 phi 的定值 bb
                for (unsigned i = 1; i < inst.get_operands().size(); i += 2) {
                    // phi 的定值 bb 是当前翻译块
                    if (inst.get_operand(i) == context.bb) {
                        auto *lvalue = inst.get_operand(i - 1);
                        if (lvalue->get_type()->is_float_type()) {
                            load_to_freg(lvalue, FReg::fa(0));
                            store_from_freg(&inst, FReg::fa(0));
                        } else {
                            load_to_greg(lvalue, Reg::a(0));
                            store_from_greg(&inst, Reg::a(0));
                        }
                        break;
                    }
                    // 如果没有找到当前翻译块，说明是 undef，无事可做
                }
            } else {
                break;
            }
        }
    }
}

void CodeGen::load_to_greg(Value *val, const Reg &reg) {
    assert(val->get_type()->is_integer_type() ||
           val->get_type()->is_pointer_type());

    if (auto *constant = dynamic_cast<ConstantInt *>(val)) {
        int32_t val = constant->get_value();
        if (IS_IMM_12(val)) {
            append_inst(ADDI WORD, {reg.print(), "$zero", std::to_string(val)});
        } else {
            load_large_int32(val, reg);
        }
    } else if (auto *global = dynamic_cast<GlobalVariable *>(val)) {
        append_inst(LOAD_ADDR, {reg.print(), global->get_name()});
    } else {
        load_from_stack_to_greg(val, reg);
    }
}

void CodeGen::load_large_int32(int32_t val, const Reg &reg) {
    int32_t high_20 = val >> 12; // si20
    uint32_t low_12 = val & LOW_12_MASK;
    append_inst(LU12I_W, {reg.print(), std::to_string(high_20)});
    append_inst(ORI, {reg.print(), reg.print(), std::to_string(low_12)});
}

void CodeGen::load_large_int64(int64_t val, const Reg &reg) {
    auto low_32 = static_cast<int32_t>(val & LOW_32_MASK);
    load_large_int32(low_32, reg);

    auto high_32 = static_cast<int32_t>(val >> 32);
    int32_t high_32_low_20 = (high_32 << 12) >> 12; // si20
    int32_t high_32_high_12 = high_32 >> 20;        // si12
    append_inst(LU32I_D, {reg.print(), std::to_string(high_32_low_20)});
    append_inst(LU52I_D,
                {reg.print(), reg.print(), std::to_string(high_32_high_12)});
}

void CodeGen::load_from_stack_to_greg(Value *val, const Reg &reg) {
    auto offset = context.offset_map.at(val);
    auto offset_str = std::to_string(offset);
    auto *type = val->get_type();
    if (IS_IMM_12(offset)) {
        if (type->is_int1_type()) {
            append_inst(LOAD BYTE, {reg.print(), "$fp", offset_str});
        } else if (type->is_int32_type()) {
            append_inst(LOAD WORD, {reg.print(), "$fp", offset_str});
        } else { // Pointer
            append_inst(LOAD DOUBLE, {reg.print(), "$fp", offset_str});
        }
    } else {
        load_large_int64(offset, reg);
        append_inst(ADD DOUBLE, {reg.print(), "$fp", reg.print()});
        if (type->is_int1_type()) {
            append_inst(LOAD BYTE, {reg.print(), reg.print(), "0"});
        } else if (type->is_int32_type()) {
            append_inst(LOAD WORD, {reg.print(), reg.print(), "0"});
        } else { // Pointer
            append_inst(LOAD DOUBLE, {reg.print(), reg.print(), "0"});
        }
    }
}

void CodeGen::store_from_greg(Value *val, const Reg &reg) {
    auto offset = context.offset_map.at(val);
    auto offset_str = std::to_string(offset);
    //std::cout << "offset: " << offset << std::endl;
    auto *type = val->get_type();
    if (IS_IMM_12(offset)) {
        if (type->is_int1_type()) {
            append_inst(STORE BYTE, {reg.print(), "$fp", offset_str});
        } else if (type->is_int32_type()) {
            append_inst(STORE WORD, {reg.print(), "$fp", offset_str});
        } else { // Pointer
            append_inst(STORE DOUBLE, {reg.print(), "$fp", offset_str});
        }
    } else {
        auto addr = Reg::t(8);
        load_large_int64(offset, addr);
        append_inst(ADD DOUBLE, {addr.print(), "$fp", addr.print()});
        if (type->is_int1_type()) {
            append_inst(STORE BYTE, {reg.print(), addr.print(), "0"});
        } else if (type->is_int32_type()) {
            append_inst(STORE WORD, {reg.print(), addr.print(), "0"});
        } else { // Pointer
            append_inst(STORE DOUBLE, {reg.print(), addr.print(), "0"});
        }
    }
}

void CodeGen::load_to_freg(Value *val, const FReg &freg) {
    assert(val->get_type()->is_float_type());
    if (auto *constant = dynamic_cast<ConstantFP *>(val)) {
        float val = constant->get_value();
        load_float_imm(val, freg);
    } else {
        auto offset = context.offset_map.at(val);
        auto offset_str = std::to_string(offset);
        if (IS_IMM_12(offset)) {
            append_inst(FLOAD SINGLE, {freg.print(), "$fp", offset_str});
        } else {
            auto addr = Reg::t(8);
            load_large_int64(offset, addr);
            append_inst(ADD DOUBLE, {addr.print(), "$fp", addr.print()});
            append_inst(FLOAD SINGLE, {freg.print(), addr.print(), "0"});
        }
    }
}

void CodeGen::load_float_imm(float val, const FReg &r) {
    int32_t bytes = *reinterpret_cast<int32_t *>(&val);
    load_large_int32(bytes, Reg::t(8));
    append_inst(GR2FR WORD, {r.print(), Reg::t(8).print()});
}

void CodeGen::store_from_freg(Value *val, const FReg &r) {
    auto offset = context.offset_map.at(val);
    if (IS_IMM_12(offset)) {
        auto offset_str = std::to_string(offset);
        append_inst(FSTORE SINGLE, {r.print(), "$fp", offset_str});
    } else {
        auto addr = Reg::t(8);
        load_large_int64(offset, addr);
        append_inst(ADD DOUBLE, {addr.print(), "$fp", addr.print()});
        append_inst(FSTORE SINGLE, {r.print(), addr.print(), "0"});
    }
}

void CodeGen::gen_prologue() {
    if (IS_IMM_12(-static_cast<int>(context.frame_size))) {
        append_inst("st.d $ra, $sp, -8");
        append_inst("st.d $fp, $sp, -16");
        append_inst("addi.d $fp, $sp, 0");
        append_inst("addi.d $sp, $sp, " +
                    std::to_string(-static_cast<int>(context.frame_size)));
    } else {
        load_large_int64(context.frame_size, Reg::t(0));
        append_inst("st.d $ra, $sp, -8");
        append_inst("st.d $fp, $sp, -16");
        append_inst("sub.d $sp, $sp, $t0");
        append_inst("add.d $fp, $sp, $t0");
    }

    int garg_cnt = 0;
    int farg_cnt = 0;
    for (auto &arg : context.func->get_args()) {
        if (arg.get_type()->is_float_type()) {
            store_from_freg(&arg, FReg::fa(farg_cnt++));
        } else { // int or pointer
            store_from_greg(&arg, Reg::a(garg_cnt++));
        }
    }
}

void CodeGen::gen_epilogue() {
    // TODO 根据你的理解设定函数的 epilogue
    append_inst(CodeGen::func_exit_label_name(context.func), ASMInstruction::Label);
    append_inst("addi.d $sp, $sp, " + std::to_string(context.frame_size));
    append_inst("ld.d $ra, $sp, -8");
    append_inst("ld.d $fp, $sp, -16");
    append_inst("jr $ra");
}


void CodeGen::gen_ret() {
    // TODO 函数返回，思考如何处理返回值、寄存器备份，如何返回调用者地址
    if (context.inst->get_num_operand() > 0) {
        auto *ret_val = context.inst->get_operand(0);
        if (ret_val->get_type()->is_float_type()) {
            load_to_freg(ret_val, FReg::fa(0));
        } else {
            assert(ret_val->get_type()->is_integer_type() || ret_val->get_type()->is_pointer_type()); // 确保 ret_val 是整数类型或指针类型
            load_to_greg(ret_val, Reg::a(0));
        }
    } else {
        append_inst("addi.w $a0, $zero, 0");
    }
    append_inst("b", {CodeGen::func_exit_label_name(context.func)});
}

void CodeGen::gen_br() {
    auto *branchInst = static_cast<BranchInst *>(context.inst);
    if (branchInst->is_cond_br()) {
        // TODO 补全条件跳转的情况
        auto *cond = branchInst->get_operand(0);
        auto *true_bb = static_cast<BasicBlock *>(branchInst->get_operand(1));
        auto *false_bb = static_cast<BasicBlock *>(branchInst->get_operand(2));

        load_to_greg(cond, Reg::t(0));
        append_inst("bnez $t0, " + label_name(true_bb));
        append_inst("b " + label_name(false_bb));
    } else {
        auto *branchbb = static_cast<BasicBlock *>(branchInst->get_operand(0));
        append_inst("b " + label_name(branchbb));
    }
}

void CodeGen::gen_binary() {
    load_to_greg(context.inst->get_operand(0), Reg::t(0));
    load_to_greg(context.inst->get_operand(1), Reg::t(1));
    switch (context.inst->get_instr_type()) {
    case Instruction::add:
        output.emplace_back("add.w $t2, $t0, $t1");
        break;
    case Instruction::sub:
        output.emplace_back("sub.w $t2, $t0, $t1");
        break;
    case Instruction::mul:
        output.emplace_back("mul.w $t2, $t0, $t1");
        break;
    case Instruction::sdiv:
        output.emplace_back("div.w $t2, $t0, $t1");
        break;
    default:
        assert(false);
    }
    store_from_greg(context.inst, Reg::t(2));
}

void CodeGen::gen_float_binary() {
    // TODO 浮点类型的二元指令
    load_to_freg(context.inst->get_operand(0), FReg::ft(0));
    load_to_freg(context.inst->get_operand(1), FReg::ft(1));
    switch (context.inst->get_instr_type()) {
    case Instruction::fadd:
        output.emplace_back("fadd.s $ft2, $ft0, $ft1");
        break;
    case Instruction::fsub:
        output.emplace_back("fsub.s $ft2, $ft0, $ft1");
        break;
    case Instruction::fmul:
        output.emplace_back("fmul.s $ft2, $ft0, $ft1");
        break;
    case Instruction::fdiv:
        output.emplace_back("fdiv.s $ft2, $ft0, $ft1");
        break;
    default:
        assert(false);
    }
    store_from_freg(context.inst, FReg::ft(2));
}

void CodeGen::gen_alloca() {
    /* 我们已经为 alloca 的内容分配空间，在此我们还需保存 alloca
     * 指令自身产生的定值，即指向 alloca 空间起始地址的指针
     */
    // TODO 将 alloca 出空间的起始地址保存在栈帧上
    auto *alloca_inst = static_cast<AllocaInst *>(context.inst);
    auto offset = context.offset_map[alloca_inst];
    //std::cout << "offset: " << offset << std::endl;
    auto *type = alloca_inst->get_alloca_type();
    if (type->is_array_type()) {
        // 生成指令，将数组的起始地址保存在栈帧上
        auto array_type = static_cast<ArrayType*>(type);
        auto num = array_type->get_num_of_elements();
        //std::cout << "num:" << num << std::endl;
        offset = offset - num * array_type->get_element_type()->get_size();
        //std::cout << "offset: " << offset << std::endl;
        append_inst("addi.d $t0, $fp, " + std::to_string(offset));
        store_from_greg(context.inst, Reg::t(0));
    } else {
        // 处理基本类型
        offset = offset - type->get_size();
        //std::cout << "offset: " << offset << std::endl;
        if (type->is_int1_type()) {
            append_inst("addi.d $t0, $fp, " + std::to_string(offset));
            store_from_greg(context.inst, Reg::t(0));
        } else if (type->is_int32_type()) {
            append_inst("addi.d $t0, $fp, " + std::to_string(offset));
            store_from_greg(context.inst, Reg::t(0));
        } else if (type->is_float_type()) {
            append_inst("addi.d $t0, $fp, " + std::to_string(offset));
            store_from_greg(context.inst, Reg::t(0));
        } else {
            append_inst("addi.d $t0, $fp, " + std::to_string(offset));
            store_from_greg(context.inst, Reg::t(0));
        }
    }
}

void CodeGen::gen_load() {
    auto *ptr = context.inst->get_operand(0);
    auto *type = context.inst->get_type();
    assert(ptr->get_type()->is_pointer_type()); // 确保 ptr 是指针类型
    load_to_greg(ptr, Reg::t(0));

    if (type->is_float_type()) {
        append_inst("fld.s $ft1, $t0, 0");
        store_from_freg(context.inst, FReg::ft(1));
    } else if (type->is_integer_type() || type->is_pointer_type()) {
        // TODO load 整数类型的数据
        auto size = type->get_size();
        if (size == 1) {
            append_inst("ld.b", {"$t0", "$t0", "0"});
        } else if (size == 2) {
            append_inst("ld.h", {"$t0", "$t0", "0"});
        } else if (size == 4) {
            append_inst("ld.w", {"$t0", "$t0", "0"});
        } else if (size == 8) {
            append_inst("ld.d", {"$t0", "$t0", "0"});
        } else {
            assert(false && "Unsupported integer size in gen_load");
        }
        store_from_greg(context.inst, Reg::t(0));
    } else {
        assert(false && "Unsupported type in gen_load");
    }
}

void CodeGen::gen_store() {
    // TODO 翻译 store 指令
    auto *val = context.inst->get_operand(0);
    auto *ptr = context.inst->get_operand(1);
    assert(ptr->get_type()->is_pointer_type()); // 确保 ptr 是指针类型
    auto *type = val->get_type();

    if (type->is_float_type()) {
        load_to_greg(ptr, Reg::t(0));
        load_to_freg(val, FReg::ft(0));
        append_inst("fst.s", {"$ft0", "$t0", "0"});
    } else if (type->is_integer_type() || type->is_pointer_type()) {
        load_to_greg(ptr, Reg::t(0));
        load_to_greg(val, Reg::t(1));
        auto size = type->get_size();
        if (size == 1) {
            append_inst("st.b", {"$t1", "$t0", "0"});
        } else if (size == 2) {
            append_inst("st.h", {"$t1", "$t0", "0"});
        } else if (size == 4) {
            append_inst("st.w", {"$t1", "$t0", "0"});
        } else if (size == 8) {
            append_inst("st.d", {"$t1", "$t0", "0"});
        } else {
            assert(false && "Unsupported integer size in gen_store");
        }
    }
}

void CodeGen::gen_icmp() {
    // TODO 处理各种整数比较的情况
    auto *lhs = context.inst->get_operand(0);
    auto *rhs = context.inst->get_operand(1);
    auto opcode = context.inst->get_instr_type();

    load_to_greg(lhs, Reg::t(0));
    load_to_greg(rhs, Reg::t(1));

    switch (opcode) {
    case Instruction::eq:
        append_inst("xor $t2, $t0, $t1");
	    append_inst("sltui $t2, $t2, 1");
        break;
    case Instruction::ne:
        append_inst("xor $t2, $t0, $t1");
        append_inst("sltu $t2, $zero, $t2");
        break;
    case Instruction::lt:
        append_inst("slt $t2, $t0, $t1");
        break;
    case Instruction::le:
        append_inst("slt $t2, $t1, $t0");
	    append_inst("xori $t2, $t2, 1");
        break;
    case Instruction::gt:
        append_inst("slt $t2, $t1, $t0");
        break;
    case Instruction::ge:
        append_inst("slt $t2, $t0, $t1");
	    append_inst("xori $t2, $t2, 1");
        break;
    default:
        assert(false);
    }
    store_from_greg(context.inst, Reg::t(2));
}

void CodeGen::gen_fcmp() {
    // TODO 处理各种浮点数比较的情况
    auto *lhs = context.inst->get_operand(0);
    auto *rhs = context.inst->get_operand(1);
    auto opcode = context.inst->get_instr_type();

    load_to_freg(lhs, FReg::ft(0));
    load_to_freg(rhs, FReg::ft(1));

    switch (opcode) {
    case Instruction::feq:
        append_inst("feq.s $t2, $ft0, $ft1");
        break;
    case Instruction::fne:
        append_inst("fne.s $t2, $ft0, $ft1");
        break;
    case Instruction::flt:
        append_inst("flt.s $t2, $ft0, $ft1");
        break;
    case Instruction::fle:
        append_inst("fle.s $t2, $ft0, $ft1");
        break;
    case Instruction::fgt:
        append_inst("fgt.s $t2, $ft0, $ft1");
        break;
    case Instruction::fge:
        append_inst("fge.s $t2, $ft0, $ft1");
        break;
    default:
        assert(false);
    }
    store_from_greg(context.inst, Reg::t(2));
}

void CodeGen::gen_zext() {
    // TODO 将窄位宽的整数数据进行零扩展
    auto *val = context.inst->get_operand(0);
    load_to_greg(val, Reg::t(0));
    append_inst("bstrpick.w $t0, $t0, 0, 0");
    store_from_greg(context.inst, Reg::t(0));
}

void CodeGen::gen_call() {
    // TODO 函数调用，注意我们只需要通过寄存器传递参数，即不需考虑栈上传参的情况
    auto *func = context.inst->get_operand(0);
    auto &args = context.inst->get_operands();

    //std::cout << "num of args: " << args.size() << std::endl;

    for (size_t i = 0; i < args.size(); ++i) {
        Value* arg = args[i];
        if (i == 0) {
            continue;
        }
        if (arg->get_type()->is_float_type()) {
            //std::cout << "Translating basic block: " << arg->print() << std::endl;
            load_to_freg(arg, FReg::fa(i-1));
        } else if (arg->get_type()->is_integer_type() || arg->get_type()->is_pointer_type()) {
            //std::cout << "Translating basic block: " << arg->print() << std::endl;
            load_to_greg(arg, Reg::a(i-1));
        }
    }

    append_inst("bl " + func->get_name());
    //std::cout << "Translating basic block: " << func->get_name() << std::endl;

    if (!context.inst->is_void()) {
        if (context.inst->get_type()->is_float_type()) {
            store_from_freg(context.inst, FReg::fa(0));
        } else {
            store_from_greg(context.inst, Reg::a(0));
        }
    }
}

/*
 * %op = getelementptr [10 x i32], [10 x i32]* %op, i32 0, i32 %op
 * %op = getelementptr        i32,        i32* %op, i32 %op
 *
 * Memory layout
 *       -            ^
 * +-----------+      | Smaller address
 * |  arg ptr  |---+  |
 * +-----------+   |  |
 * |           |   |  |
 * +-----------+   /  |
 * |           |<--   |
 * |           |   \  |
 * |           |   |  |
 * |   Array   |   |  |
 * |           |   |  |
 * |           |   |  |
 * |           |   |  |
 * +-----------+   |  |
 * |  Pointer  |---+  |
 * +-----------+      |
 * |           |      |
 * +-----------+      |
 * |           |      |
 * +-----------+      |
 * |           |      |
 * +-----------+      | Larger address
 *       +
 */
void CodeGen::gen_gep() {
    // TODO 计算内存地址
    auto *ptr = context.inst->get_operand(0);
    auto *index = context.inst->get_operand(1);
    auto *type = context.inst->get_type()->get_pointer_element_type();
    auto *pointer_type = static_cast<PointerType*>(ptr->get_type());
    if (pointer_type->get_element_type()->is_array_type()) {
        auto *offest = context.inst->get_operand(2);
        std::cout << offest->print() << std::endl;
        auto *array_type = static_cast<ArrayType*>(pointer_type->get_element_type());
        auto size_array = array_type->get_num_of_elements();

        load_to_greg(ptr, Reg::t(0));
        load_to_greg(index, Reg::t(1));

        auto size = type->get_size();
        if (size_array * size <= 2047) {
            append_inst("addi.d $t2, $zero, " + std::to_string(size_array * size));
        } else {
            auto size_of_array = size_array * size;
            std::vector<std::pair<int, int>> times_remain;
            while (size_of_array > 2047) {
                auto times = size_of_array / 2047;
                auto remain = size_of_array % 2047;
                times_remain.push_back(std::make_pair(times > 2047?0:times, remain));
                size_of_array = times;
            }
            append_inst("addi.d $t3, $zero, 2047");
            bool is_first = true;
            for (auto it = times_remain.rbegin(); it != times_remain.rend(); ++it) {
                const auto &pair = *it;
                if (is_first) {
                    // 处理第一个 pair 的逻辑
                    is_first = false;
                    append_inst("addi.d $t2, $zero, " + std::to_string(pair.first));
                }
                append_inst("mul.d $t2, $t2, $t3");
                append_inst("addi.d $t2, $t2, " + std::to_string(pair.second));
            }
        }
	    append_inst("mul.d $t1, $t1, $t2");
	    append_inst("add.d $t0, $t0, $t1");
        std::cout << offest->get_name() << std::endl;
        if (offest->get_name().front() < '0' || offest->get_name().front() > '9') {
            load_to_greg(offest, Reg::t(1));
        } else {
            append_inst("addi.w $t1, $zero, " + offest->print());
        }
	    append_inst("addi.d $t2, $zero, " + std::to_string(size));
	    append_inst("mul.d $t1, $t1, $t2");
	    append_inst("add.d $t0, $t0, $t1");
        store_from_greg(context.inst, Reg::t(0));
    } else {
        load_to_greg(ptr, Reg::t(0));
        load_to_greg(index, Reg::t(1));

        auto size = type->get_size();
        append_inst("addi.d $t2, $zero, " + std::to_string(size));
        append_inst("mul.d $t1, $t1, $t2");
	    append_inst("add.d $t0, $t0, $t1");
        store_from_greg(context.inst, Reg::t(0));
    }
    
}

void CodeGen::gen_sitofp() {
    // TODO 整数转向浮点数
    auto *val = context.inst->get_operand(0);
    load_to_greg(val, Reg::t(0));
    append_inst("movgr2fr.w $ft0, $t0");
    append_inst("ffint.s.w $ft0, $ft0");
    store_from_freg(context.inst, FReg::ft(0));
}

void CodeGen::gen_fptosi() {
    // TODO 浮点数转向整数，注意向下取整(round to zero)
    auto *val = context.inst->get_operand(0);
    load_to_freg(val, FReg::ft(0));
    append_inst("ftintrz.w.s $ft0, $ft0");
    append_inst("movfr2gr.s $t0, $ft0");
    store_from_greg(context.inst, Reg::t(0));
}

void CodeGen::run() {
    // 确保每个函数中基本块的名字都被设置好
    m->set_print_name();

    /* 使用 GNU 伪指令为全局变量分配空间
     * 你可以使用 `la.local` 指令将标签 (全局变量) 的地址载入寄存器中, 比如
     * 要将 `a` 的地址载入 $t0, 只需要 `la.local $t0, a`
     */
    if (!m->get_global_variable().empty()) {
        append_inst("Global variables", ASMInstruction::Comment);
        /* 虽然下面两条伪指令可以简化为一条 `.bss` 伪指令, 但是我们还是选择使用
         * `.section` 将全局变量放到可执行文件的 BSS 段, 原因如下:
         * - 尽可能对齐交叉编译器 loongarch64-unknown-linux-gnu-gcc 的行为
         * - 支持更旧版本的 GNU 汇编器, 因为 `.bss` 伪指令是应该相对较新的指令,
         *   GNU 汇编器在 2023 年 2 月的 2.37 版本才将其引入
         */
        append_inst(".text", ASMInstruction::Atrribute);
        append_inst(".section", {".bss", "\"aw\"", "@nobits"},
                    ASMInstruction::Atrribute);
        for (auto &global : m->get_global_variable()) {
            auto size =
                global.get_type()->get_pointer_element_type()->get_size();
            append_inst(".globl", {global.get_name()},
                        ASMInstruction::Atrribute);
            append_inst(".type", {global.get_name(), "@object"},
                        ASMInstruction::Atrribute);
            append_inst(".size", {global.get_name(), std::to_string(size)},
                        ASMInstruction::Atrribute);
            append_inst(global.get_name(), ASMInstruction::Label);
            append_inst(".space", {std::to_string(size)},
                        ASMInstruction::Atrribute);
        }
    }

    // 函数代码段
    output.emplace_back(".text", ASMInstruction::Atrribute);
    for (auto &func : m->get_functions()) {
        if (not func.is_declaration()) {
            // 更新 context
            context.clear();
            context.func = &func;

            // 函数信息
            append_inst(".globl", {func.get_name()}, ASMInstruction::Atrribute);
            append_inst(".type", {func.get_name(), "@function"},
                        ASMInstruction::Atrribute);
            append_inst(func.get_name(), ASMInstruction::Label);

            // 分配函数栈帧
            allocate();
            // 生成 prologue
            gen_prologue();

            for (auto &bb : func.get_basic_blocks()) {
                context.bb = &bb;
                append_inst(label_name(context.bb), ASMInstruction::Label);
                //std::cout << "Translating basic block: " << label_name(context.bb) << std::endl;
                for (auto &instr : bb.get_instructions()) {
                    // For debug
                    append_inst(instr.print(), ASMInstruction::Comment);
                    //std::cout << "Translating basic block: " << instr.print() << std::endl;
                    context.inst = &instr; // 更新 context
                    switch (instr.get_instr_type()) {
                    case Instruction::ret:
                        gen_ret();
                        break;
                    case Instruction::br:
                        copy_stmt();
                        gen_br();
                        break;
                    case Instruction::add:
                    case Instruction::sub:
                    case Instruction::mul:
                    case Instruction::sdiv:
                        gen_binary();
                        break;
                    case Instruction::fadd:
                    case Instruction::fsub:
                    case Instruction::fmul:
                    case Instruction::fdiv:
                        gen_float_binary();
                        break;
                    case Instruction::alloca:
                        /* 对于 alloca 指令，我们已经为 alloca
                         * 的内容分配空间，在此我们还需保存 alloca
                         * 指令自身产生的定值，即指向 alloca 空间起始地址的指针
                         */
                        gen_alloca();
                        break;
                    case Instruction::load:
                        gen_load();
                        break;
                    case Instruction::store:
                        gen_store();
                        break;
                    case Instruction::ge:
                    case Instruction::gt:
                    case Instruction::le:
                    case Instruction::lt:
                    case Instruction::eq:
                    case Instruction::ne:
                        gen_icmp();
                        break;
                    case Instruction::fge:
                    case Instruction::fgt:
                    case Instruction::fle:
                    case Instruction::flt:
                    case Instruction::feq:
                    case Instruction::fne:
                        gen_fcmp();
                        break;
                    case Instruction::phi:
                        /* for phi, just convert to a series of
                         * copy-stmts */
                        /* we can collect all phi and deal them at
                         * the end */
                        break;
                    case Instruction::call:
                        gen_call();
                        break;
                    case Instruction::getelementptr:
                        gen_gep();
                        break;
                    case Instruction::zext:
                        gen_zext();
                        break;
                    case Instruction::fptosi:
                        gen_fptosi();
                        break;
                    case Instruction::sitofp:
                        gen_sitofp();
                        break;
                    }
                }
            }
            // 生成 epilogue
            gen_epilogue();
        }
    }
}

std::string CodeGen::print() const {
    std::string result;
    for (const auto &inst : output) {
        result += inst.format();
    }
    return result;
}
