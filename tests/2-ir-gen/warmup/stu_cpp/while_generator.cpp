#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <iostream>
#include <memory>

#define CONST_INT(num) ConstantInt::get(num, module)

int main() {
    auto module = new Module();
    auto builder = new IRBuilder(nullptr, module);
    Type *Int32Type = module->get_int32_type();
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    auto entryBB = BasicBlock::create(module, "entry", mainFun);
    builder->set_insert_point(entryBB);
    auto aAlloca = builder->create_alloca(Int32Type);
    auto iAlloca = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(10), aAlloca);
    builder->create_store(CONST_INT(0), iAlloca);
    auto condBB = BasicBlock::create(module, "cond", mainFun);
    auto bodyBB = BasicBlock::create(module, "body", mainFun);
    auto endBB = BasicBlock::create(module, "end", mainFun);
    // 跳转到 condBB
    builder->create_br(condBB);
    // 在 condBB 中创建条件判断
    builder->set_insert_point(condBB);
    auto iLoad = builder->create_load(iAlloca);
    auto cond = builder->create_icmp_lt(iLoad, CONST_INT(10));
    builder->create_cond_br(cond, bodyBB, endBB);
    // 在 bodyBB 中创建循环体
    builder->set_insert_point(bodyBB);
    iLoad = builder->create_load(iAlloca);
    auto iInc = builder->create_iadd(iLoad, CONST_INT(1));
    builder->create_store(iInc, iAlloca);
    auto aLoad = builder->create_load(aAlloca);
    auto aInc = builder->create_iadd(aLoad, iInc);
    builder->create_store(aInc, aAlloca);
    builder->create_br(condBB);
    // 在 endBB 中返回结果
    builder->set_insert_point(endBB);
    aLoad = builder->create_load(aAlloca);
    builder->create_ret(aLoad);
    std::cout << module->print();
    delete module;
    return 0;
}