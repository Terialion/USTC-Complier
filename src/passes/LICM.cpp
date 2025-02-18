#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "GlobalVariable.hpp"
#include "Instruction.hpp"
#include "LICM.hpp"
#include "PassManager.hpp"
#include <cstddef>
#include <iostream>
#include <memory>
#include <vector>

/**
 * @brief 循环不变式外提Pass的主入口函数
 * 
 */
void LoopInvariantCodeMotion::run() {

    loop_detection_ = std::make_unique<LoopDetection>(m_);
    loop_detection_->run();
    func_info_ = std::make_unique<FuncInfo>(m_);
    func_info_->run();
    for (auto &loop : loop_detection_->get_loops()) {
        is_loop_done_[loop] = false;
    }

    for (auto &loop : loop_detection_->get_loops()) {
        traverse_loop(loop);
    }
}

/**
 * @brief 遍历循环及其子循环
 * @param loop 当前要处理的循环
 * 
 */
void LoopInvariantCodeMotion::traverse_loop(std::shared_ptr<Loop> loop) {
    if (is_loop_done_[loop]) {
        return;
    }
    is_loop_done_[loop] = true;
    for (auto &sub_loop : loop->get_sub_loops()) {
        traverse_loop(sub_loop);
    }
    run_on_loop(loop);
}
    // 1. 遍历当前循环及其子循环的所有指令
    // 2. 收集所有指令到loop_instructions中
    // 3. 检查store指令是否修改了全局变量，如果是则添加到updated_global中
    // 4. 检查是否包含非纯函数调用，如果有则设置contains_impure_call为true
void LoopInvariantCodeMotion::collect_loop_info(
    std::shared_ptr<Loop> loop,
    std::set<Value *> &loop_instructions,
    std::set<Value *> &updated_global,
    bool &contains_impure_call) {
    
    for (auto &bb : loop->get_blocks()) {
        for (auto &inst : bb->get_instructions()) {
            loop_instructions.insert(&inst);
            std::cout << "Instruction: " << inst.print() << std::endl;
            if (inst.is_store()) {
                auto gv = inst.get_operand(1);
                if (updated_global.find(gv) == updated_global.end()) {
                    updated_global.insert(gv);
                }
            }
            if (inst.is_call()) {
                auto func = inst.get_operand(0);
                if (!func_info_->is_pure_function(dynamic_cast<Function *>(func))) {
                    contains_impure_call = true;
                }
            }
        }
    }
}

/**
 * @brief 对单个循环执行不变式外提优化
 * @param loop 要优化的循环
 * 
 */
void LoopInvariantCodeMotion::run_on_loop(std::shared_ptr<Loop> loop) {
    std::set<Value *> loop_instructions;
    std::set<Value *> updated_global;
    bool contains_impure_call = false;
    collect_loop_info(loop, loop_instructions, updated_global, contains_impure_call);

    std::vector<Value *> loop_invariant;


    // TODO: 识别循环不变式指令
    //
    // - 如果指令已被标记为不变式则跳过
    // - 跳过 store、ret、br、phi 等指令与非纯函数调用
    // - 特殊处理全局变量的 load 指令
    // - 检查指令的所有操作数是否都是循环不变的
    // - 如果有新的不变式被添加则注意更新 changed 标志，继续迭代

    bool changed;
    do {
        changed = false;

        for (auto &instruction : loop_instructions) {
            auto &inst = *dynamic_cast<Instruction *>(instruction);
            std::cout << "Instruction: " << inst.print() << std::endl;
            if (std::find(loop_invariant.begin(), loop_invariant.end(), instruction) != loop_invariant.end()) {
                continue;
            }

            if (inst.is_store() || inst.is_ret() || inst.is_br() || inst.is_phi()) {
                continue;
            }

            if (inst.is_call()) {
                auto func = inst.get_operand(0);
                if (!func_info_->is_pure_function(dynamic_cast<Function *>(func))) {
                    contains_impure_call = true;
                    continue;
                }
            }

            if (inst.is_load()) {
                for (auto &operand : inst.get_operands()) {
                    std::cout << "Load operand: " << operand->get_name() << std::endl;
                }
                auto gv = inst.get_operand(0);
                if (updated_global.count(gv)) {
                    continue;
                }
                if (auto global_var = dynamic_cast<GlobalVariable *>(gv)) {
                    // 如果是全局变量的 load 指令，视为循环不变
                    loop_invariant.push_back(instruction);
                    changed = true;
                    continue;
                }
            }

            bool is_invariant = true;
            for (auto &operand : inst.get_operands()) {
                if (loop_instructions.find(operand) != loop_instructions.end() &&
                    std::find(loop_invariant.begin(), loop_invariant.end(), operand) == loop_invariant.end()) {
                    is_invariant = false;
                    break;
                }
            }

            if (is_invariant) {
                loop_invariant.push_back(instruction);
                changed = true;
            }
        }
    } while (changed);

    if (loop->get_preheader() == nullptr) {
        loop->set_preheader(
            BasicBlock::create(m_, "", loop->get_header()->get_parent()));
    }

    if (loop_invariant.empty())
        return;
    
    for (auto &inst : loop_invariant) {
        std::cout << "Loop invariant: " << dynamic_cast<Instruction *>(inst)->get_name() << std::endl;
    }

    // insert preheader
    auto preheader = loop->get_preheader();

    // TODO: 更新 phi 指令
    std::vector<std::pair<Value *, BasicBlock *>> phi_updates;
    for (auto &phi_inst_ : loop->get_header()->get_instructions()) {
        if (phi_inst_.get_instr_type() != Instruction::phi)
            break;
        
        std::cout << "Phi instruction: " << phi_inst_.get_name() << std::endl;
        auto phi = dynamic_cast<PhiInst *>(&phi_inst_);
        for (unsigned i = 0; i < phi->get_num_operand(); i += 2) {
            auto val = dynamic_cast<Value *>(phi->get_operand(i));
            auto pre_bb = dynamic_cast<BasicBlock *>(phi->get_operand(i + 1));
            if (std::find(loop->get_blocks().begin(), loop->get_blocks().end(), pre_bb) != loop->get_blocks().end())
                continue;
            phi_updates.push_back({val, pre_bb});
            std::cout << "Phi operand: " << val->get_name() << " " << pre_bb->get_name() << std::endl;
            std::cout << "Phi operand: " << val->get_name() << " " << preheader->get_name() << std::endl;
        }
        for (auto &update : phi_updates) {
            auto val = update.first;
            auto pre_bb = update.second;
            phi->remove_phi_operand(pre_bb);
            phi->add_phi_pair_operand(val, preheader);
        }
        phi_updates.clear();
    }

    for (auto mem:loop->get_latches()) {
        std::cout << "Latch: " << mem->get_name() << std::endl;
    }

    for (auto &mem : loop->get_blocks()) {
        std::cout << "Loop block: " << mem->get_name() << std::endl;
    }

    // TODO: 用跳转指令重构控制流图 
    // 将所有非 latch 的 header 前驱块的跳转指向 preheader
    // 并将 preheader 的跳转指向 header
    // 注意这里需要更新前驱块的后继和后继的前驱
    std::vector<BasicBlock *> pred_to_remove;
    for (auto &pred : loop->get_header()->get_pre_basic_blocks()) {
        std::cout << "Pre header pred: " << pred->get_name() << std::endl;
        if (loop->get_latches().find(pred) != loop->get_latches().end())
            continue;
        for (auto succ : pred->get_succ_basic_blocks()) {
            std::cout << "Pre header succ: " << succ->get_name() << std::endl;
        }
        pred->remove_succ_basic_block(loop->get_header());
        pred->add_succ_basic_block(preheader);
        for (auto succ : pred->get_succ_basic_blocks()) {
            std::cout << "Pre header succ: " << succ->get_name() << std::endl;
        }
        for (auto &inst : pred->get_instructions()) {
            if (inst.is_br()) {
                std::cout << "Br instruction: " << inst.print() << std::endl;
                auto br = dynamic_cast<BranchInst *>(&inst);
                if (br->is_cond_br()) {
                    std::cout << "Cond br: " << br->get_operand(1) << br->get_operand(2) << std::endl;
                    if (br->get_operand(1) == loop->get_header()) {
                        br->set_operand(1, preheader);
                    }
                    if (br->get_operand(2) == loop->get_header()) {
                        br->set_operand(2, preheader);
                    }
                }  else {
                    std::cout << "Uncond br: " << br->get_operand(0)->get_name() << std::endl;
                    br->set_operand(0, preheader);
                    std::cout << "Uncond br: " << br->get_operand(0)->get_name() << std::endl;
                }
            }
        }
        preheader->add_pre_basic_block(pred);
        pred_to_remove.push_back(pred);
    }

    for (auto &pred : pred_to_remove) {
        std::cout << "Remove pred: " << pred->get_name() << std::endl;
        loop->get_header()->remove_pre_basic_block(pred);
        for (auto succ : pred->get_succ_basic_blocks()) {
            std::cout << "Pre header succ: " << succ->get_name() << std::endl;
        }
    }

    preheader->add_succ_basic_block(loop->get_header());

    for (auto &pred : preheader->get_pre_basic_blocks()) {
        std::cout << "Pre header pred: " << pred->get_name() << std::endl;
    }

    for (auto $mem : loop->get_header()->get_pre_basic_blocks()) {
        std::cout << "Pre header pred: " << $mem->get_name() << std::endl;
    }

    // TODO: 外提循环不变指令
    for (auto &inst : loop_invariant) {
        auto instruction = dynamic_cast<Instruction *>(inst);
        std::cout << "Move instruction: " << instruction->get_name() << std::endl;
        instruction->get_parent()->remove_instr(instruction);
        std::cout << "Instruction parent: " << instruction->get_parent()->get_name() << std::endl;
        preheader->add_instruction(instruction);
        instruction->set_parent(preheader);
        std::cout << "Instruction parent: " << instruction->get_parent()->get_name() << std::endl;
    }

    for (auto &inst : preheader->get_instructions()) {
        std::cout << "Preheader instruction: " << inst.get_name() << std::endl;
    }

    // insert preheader br to header
    BranchInst::create_br(loop->get_header(), preheader);

    // insert preheader to parent loop
    if (loop->get_parent() != nullptr) {
        loop->get_parent()->add_block(preheader);
    }
}

