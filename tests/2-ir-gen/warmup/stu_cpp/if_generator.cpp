#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <iostream>
#include <memory>

#define CONST_INT(num) ConstantInt::get(num, module)
#define CONST_FP(num) ConstantFP::get(num, module)

int main() {
    auto module = new Module();
    auto builder = new IRBuilder(nullptr, module);
    Type *FloatType = module->get_float_type();
    Type *Int32Type = module->get_int32_type();
    // 创建 main 函数
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    // 创建 main 函数的起始基本块
    auto entryBB = BasicBlock::create(module, "entry", mainFun);
    // 将 builder 插入指令的位置设置在 main 函数的起始基本块
    builder->set_insert_point(entryBB);
    // 为局部变量 a 分配空间
    auto aAlloca = builder->create_alloca(FloatType);
    // 初始化变量 a
    builder->create_store(CONST_FP(5.555), aAlloca);
    // 创建 if 语句的基本块
    auto ifTrueBB = BasicBlock::create(module, "ifTrue", mainFun);
    auto endBB = BasicBlock::create(module, "ifFalse", mainFun);
    // 在 entryBB 中创建条件判断
    auto aLoad = builder->create_load(aAlloca);
    auto cond = builder->create_fcmp_gt(aLoad, CONST_FP(1.0));
    builder->create_cond_br(cond, ifTrueBB, endBB);
    // 在 ifTrueBB 中创建返回 233 的指令
    builder->set_insert_point(ifTrueBB);
    builder->create_ret(CONST_INT(233));
    // 在 ifFalseBB 中创建返回 0 的指令
    builder->set_insert_point(endBB);
    builder->create_ret(CONST_INT(0));
    std::cout << module->print();
    delete module;
    return 0;
}