#include "cminusf_builder.hpp"
#include "Type.hpp"
#include <cstddef>
#include <iostream>

#define CONST_FP(num) ConstantFP::get((float)num, module.get())
#define CONST_INT(num) ConstantInt::get(num, module.get())

// types
Type *VOID_T;
Type *INT1_T;
Type *INT32_T;
Type *INT32PTR_T;
Type *FLOAT_T;
Type *FLOATPTR_T;

/*
 * use CMinusfBuilder::Scope to construct scopes
 * scope.enter: enter a new scope
 * scope.exit: exit current scope
 * scope.push: add a new binding to current scope
 * scope.find: find and return the value bound to the name
 */

Value* CminusfBuilder::visit(ASTProgram &node) {
    VOID_T = module->get_void_type();
    INT1_T = module->get_int1_type();
    INT32_T = module->get_int32_type();
    INT32PTR_T = module->get_int32_ptr_type();
    FLOAT_T = module->get_float_type();
    FLOATPTR_T = module->get_float_ptr_type();

    Value *ret_val = nullptr;
    for (auto &decl : node.declarations) {
        ret_val = decl->accept(*this);
    }
    return ret_val;
}

Value* CminusfBuilder::visit(ASTNum &node) {
    // TODO: This function is empty now.
    // Add some code here.
    if (node.type == TYPE_INT) {
        return CONST_INT(node.i_val);
    } else if (node.type == TYPE_FLOAT) {
        return CONST_FP(node.f_val);
    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTVarDeclaration &node) {//变量声明
    // TODO: This function is empty now.
    // Add some code here.
    Type *var_type;
    ArrayType *arrayType;
    if (node.num  == nullptr) {
        if (node.type == TYPE_INT) {
            var_type = INT32_T;
        } else if (node.type == TYPE_FLOAT) {
            var_type = FLOAT_T;
        }
    } else if (node.num->type == TYPE_INT && node.num->i_val > 0) {
        if (node.type == TYPE_INT) {
            arrayType = ArrayType::get(INT32_T, node.num->i_val);
        } else if (node.type == TYPE_FLOAT) {
            arrayType = ArrayType::get(FLOAT_T, node.num->i_val);
        }
    } else {
        return nullptr;
    }

    Value *var;
    if (scope.in_global()) {
        if (node.num == nullptr) {
            auto initializer = ConstantZero::get(INT32_T, module.get());
            var = GlobalVariable::create(node.id, module.get(), var_type, false, initializer);
        } else {
            auto initializer = ConstantZero::get(INT32_T, module.get());
            var = GlobalVariable::create(node.id, module.get(), arrayType, false, initializer);
        }
    } else {
        if (node.num == nullptr) {
            var = builder->create_alloca(var_type);
        } else {
            var = builder->create_alloca(arrayType);
        }
    }
    scope.push(node.id, var);
    return var;
}

Value* CminusfBuilder::visit(ASTFunDeclaration &node) {//函数声明
    FunctionType *fun_type;
    Type *ret_type;
    std::vector<Type *> param_types;

    if (node.type == TYPE_INT)
        ret_type = INT32_T;
    else if (node.type == TYPE_FLOAT)
        ret_type = FLOAT_T;
    else
        ret_type = VOID_T;

    for (auto &param : node.params) {
        // TODO: Please accomplish param_types.
        if (param->type == TYPE_INT)
            if (param->isarray)
                param_types.push_back(INT32PTR_T);
            else
                param_types.push_back(INT32_T);
        else if (param->type == TYPE_FLOAT)
            if (param->isarray)
                param_types.push_back(FLOATPTR_T);
            else
                param_types.push_back(FLOAT_T);
        else 
            return nullptr;
    }

    fun_type = FunctionType::get(ret_type, param_types);
    auto func = Function::create(fun_type, node.id, module.get());
    scope.push(node.id, func);
    context.func = func;
    auto funBB = BasicBlock::create(module.get(), "entry", func);
    builder->set_insert_point(funBB);
    scope.enter();
    std::vector<Value *> args;
    for (auto &arg : func->get_args()) {
        args.push_back(&arg);
    }
    for (unsigned int i = 0; i < node.params.size(); ++i) {
        // TODO: You need to deal with params and store them in the scope.
        auto param = builder->create_alloca(param_types[i]);//创建局部变量
        builder->create_store(args[i], param);//存储参数
        scope.push(node.params[i]->id, param);//存在scope里面，虽然我自己也不知道为什么这么干，哭了
    }
    node.compound_stmt->accept(*this);
    if (not builder->get_insert_block()->is_terminated()) 
    {
        if (context.func->get_return_type()->is_void_type())
            builder->create_void_ret();
        else if (context.func->get_return_type()->is_float_type())
            builder->create_ret(CONST_FP(0.));
        else
            builder->create_ret(CONST_INT(0));
    }
    scope.exit();
    return nullptr;
}

Value* CminusfBuilder::visit(ASTParam &node) {//参数
    // TODO: This function is empty now.
    // Add some code here.
    Type *param_type;////////////////////////////array要改这
    if (node.type == TYPE_INT) {
        param_type = INT32_T;
    } else if (node.type == TYPE_FLOAT) {
        param_type = FLOAT_T;
    } else {
        return nullptr;
    }
    
    Value *param = builder->create_alloca(param_type);
    scope.push(node.id, param);
    return param;
}

Value* CminusfBuilder::visit(ASTCompoundStmt &node) {
    // TODO: This function is not complete.
    // You may need to add some code here
    // to deal with complex statements. 
    scope.enter();
    for (auto &decl : node.local_declarations) {
        decl->accept(*this);
    }

    for (auto &stmt : node.statement_list) {
        stmt->accept(*this);
        if (builder->get_insert_block()->is_terminated())
            break;
    }
    scope.exit();
    return nullptr;
}

Value* CminusfBuilder::visit(ASTExpressionStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.
    if (node.expression != nullptr) {
        node.expression->accept(*this);
    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTSelectionStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto cond = node.expression->accept(*this);
    if (!cond->get_type()->is_int1_type()) {
        if (cond->get_type()->is_float_type()) {
            cond = builder->create_fcmp_ne(cond, CONST_FP(0.));
        } else {
            cond = builder->create_icmp_ne(cond, CONST_INT(0));
        }
    }
    auto trueBB = BasicBlock::create(module.get(), "", context.func);
    auto endBB = BasicBlock::create(module.get(), "", context.func);

    if(node.else_statement)
    {
        auto falseBB = BasicBlock::create(module.get(), "", context.func);
        builder->create_cond_br(cond, trueBB, falseBB);
        builder->set_insert_point(trueBB);
        node.if_statement->accept(*this);
        if(!builder->get_insert_block()->is_terminated())
        {
            builder->create_br(endBB);
        }
        builder->set_insert_point(falseBB);
        node.else_statement->accept(*this);
        if(!builder->get_insert_block()->is_terminated())
        {
            builder->create_br(endBB);
        }
    }
    else{
        builder->create_cond_br(cond, trueBB, endBB);
        builder->set_insert_point(trueBB);
        node.if_statement->accept(*this);
        if(!builder->get_insert_block()->is_terminated())
        {
            builder->create_br(endBB);
        }
    }

    builder->set_insert_point(endBB);
    return nullptr;
}

Value* CminusfBuilder::visit(ASTIterationStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto condBB = BasicBlock::create(module.get(), "", context.func);
    auto loopBB = BasicBlock::create(module.get(), "", context.func);
    auto endBB = BasicBlock::create(module.get(), "", context.func);

    builder->create_br(condBB);
    builder->set_insert_point(condBB);
    auto cond = node.expression->accept(*this);
    if (!cond->get_type()->is_int1_type()) {
        if (cond->get_type()->is_float_type()) {
            cond = builder->create_fcmp_ne(cond, CONST_FP(0.));
        } else {
            cond = builder->create_icmp_ne(cond, CONST_INT(0));
        }
    }
    builder->create_cond_br(cond, loopBB, endBB);

    builder->set_insert_point(loopBB);
    node.statement->accept(*this);
    if (!builder->get_insert_block()->is_terminated()) {
        builder->create_br(condBB);
    }
    builder->set_insert_point(endBB);
    return nullptr;
}

Value* CminusfBuilder::visit(ASTReturnStmt &node) {
    if (node.expression == nullptr) {
        builder->create_void_ret();
        return nullptr;
    } else {
        // TODO: The given code is incomplete.
        // You need to solve other return cases (e.g. return an integer).
        auto ret_val = node.expression->accept(*this);
        if (context.func->get_return_type()->is_float_type() && !ret_val->get_type()->is_float_type()) {
            ret_val = builder->create_sitofp(ret_val, FLOAT_T);
        } else if (context.func->get_return_type()->is_integer_type() && !ret_val->get_type()->is_integer_type()) {
            ret_val = builder->create_fptosi(ret_val, INT32_T);
        }
        builder->create_ret(ret_val);
    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTVar &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto var = scope.find(node.id);//找到这边变量
    if (node.expression == nullptr) {
        if (var->get_type()->get_pointer_element_type()->is_array_type()) {
            return var;
        } else {
            return builder->create_load(var);
        }
    } else {
        auto index = node.expression->accept(*this);
        if (index->get_type()->is_float_type()) {
            index = builder->create_fptosi(index, INT32_T);
        }
        auto func = scope.find("neg_idx_except");
        std::vector<Value*> args;
        auto cond = builder->create_icmp_lt(index, CONST_INT(0));
        auto trueBB = BasicBlock::create(module.get(), "", context.func);
        auto falseBB = BasicBlock::create(module.get(), "", context.func);
        builder->create_cond_br(cond, trueBB, falseBB);
        builder->set_insert_point(trueBB);
        builder->create_call(func, {});
        builder->create_br(falseBB);
        builder->set_insert_point(falseBB);
        if (var->get_type()->is_pointer_type()) {
            auto elementType = var->get_type()->get_pointer_element_type();
            if (elementType->is_array_type()) {
                auto gep = builder->create_gep(var, {CONST_INT(0), index});
                return builder->create_load(gep);
            } else if (elementType->is_pointer_type()) {
                auto var_load = builder->create_load(var);
                auto gep = builder->create_gep(var_load, {index});//some question
                return builder->create_load(gep);
            }else {
                auto gep = builder->create_gep(var, {index});
                return builder->create_load(gep);
            }
        }
    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTAssignExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto left = scope.find(node.var->id);
    auto right = node.expression->accept(*this);
    if (node.var->expression != nullptr) {
        auto idx = node.var->expression->accept(*this);
        if (idx->get_type()->is_float_type()) {
            idx = builder->create_fptosi(idx, INT32_T);
        }
        Value* gep;
        auto elementType = left->get_type()->get_pointer_element_type();
        if (elementType->is_array_type()) {
            gep = builder->create_gep(left, {CONST_INT(0), idx});
        } else {
            auto left_load = builder->create_load(left);
            gep = builder->create_gep(left_load, {idx});
        }
        if (elementType->is_array_type()) {
            if(left->get_type()->get_pointer_element_type()->get_array_element_type()->is_float_type() && !right->get_type()->is_float_type())
            {
                right = builder->create_sitofp(right, FLOAT_T);
            } else if(left->get_type()->get_pointer_element_type()->get_array_element_type()->is_integer_type() && !right->get_type()->is_integer_type()) {
                right = builder->create_fptosi(right, INT32_T);
            }
        }
        if(gep->get_type()->get_pointer_element_type()->is_float_type() && !right->get_type()->is_float_type()) {
            right = builder->create_sitofp(right, FLOAT_T);
        } else if(gep->get_type()->get_pointer_element_type()->is_integer_type() && !right->get_type()->is_integer_type()) {
            right = builder->create_fptosi(right, INT32_T);
        }
        builder->create_store(right, gep);
    } else {
        if (left->get_type()->is_pointer_type()) {
            auto left_element_type = left->get_type()->get_pointer_element_type();
            if (left_element_type->is_float_type() && right->get_type()->is_integer_type()) {
                right = builder->create_sitofp(right, FLOAT_T);
            } else if (left_element_type->is_integer_type() && right->get_type()->is_float_type()) {
                right = builder->create_fptosi(right, INT32_T);
            } else if (left_element_type->is_integer_type() && right->get_type()->is_integer_type()) {
                if (left_element_type->is_int32_type() && right->get_type()->is_int1_type()) {
                    right = builder->create_zext(right, left_element_type);
                }
                else if (left_element_type->is_int1_type() && right->get_type()->is_int32_type()) {
                    right = builder->create_zext(right, left_element_type);
                }
            }
        }
        builder->create_store(right, left);
    }
    return right;
}

Value* CminusfBuilder::visit(ASTSimpleExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto left = node.additive_expression_l->accept(*this);
    if (node.additive_expression_r != nullptr) {
        auto right = node.additive_expression_r->accept(*this);
        if (left->get_type()->is_float_type() || right->get_type()->is_float_type()) {
            if (left->get_type()->is_integer_type()) {
                left = builder->create_sitofp(left, FLOAT_T);
            }
            if (right->get_type()->is_integer_type()) {
                right = builder->create_sitofp(right, FLOAT_T);
            }
            if (node.op == OP_LT) {
                return builder->create_fcmp_lt(left, right);
            } else if (node.op == OP_LE) {
                return builder->create_fcmp_le(left, right);
            } else if (node.op == OP_GT) {
                return builder->create_fcmp_gt(left, right);
            } else if (node.op == OP_GE) {
                return builder->create_fcmp_ge(left, right);
            } else if (node.op == OP_EQ) {
                return builder->create_fcmp_eq(left, right);
            } else if (node.op == OP_NEQ) {
                return builder->create_fcmp_ne(left, right);
            } else {
                assert(0 && "Invalid relational operator");
                return nullptr;
            }
        } 
        else {
            if (right->get_type()->is_int32_type() && left->get_type()->is_int1_type()) {
                left = builder->create_zext(left, INT32_T);
            }
            else if (right->get_type()->is_int1_type() && left->get_type()->is_int32_type()) {
                right = builder->create_zext(right, INT32_T);
            }
            else if (right->get_type()->is_int1_type() && left->get_type()->is_int1_type()) {
                left = builder->create_zext(left, INT32_T);
                right = builder->create_zext(right, INT32_T);
            }
            if (node.op == OP_LT) {
                return builder->create_icmp_lt(left, right);
            } else if (node.op == OP_LE) {
                return builder->create_icmp_le(left, right);
            } else if (node.op == OP_GT) {
                return builder->create_icmp_gt(left, right);
            } else if (node.op == OP_GE) {
                return builder->create_icmp_ge(left, right);
            } else if (node.op == OP_EQ) {
                return builder->create_icmp_eq(left, right);
            } else if (node.op == OP_NEQ) {
                return builder->create_icmp_ne(left, right);
            } else {
                assert(0 && "Invalid relational operator");
                return nullptr;
            }
        }
    }
    return left;
}

Value* CminusfBuilder::visit(ASTAdditiveExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto right = node.term->accept(*this);
    if (node.additive_expression != nullptr) {
        auto left = node.additive_expression->accept(*this);
        if (left->get_type()->is_float_type() || right->get_type()->is_float_type()) {
            if (left->get_type()->is_integer_type()) {
                left = builder->create_sitofp(left, FLOAT_T);
            }
            if (right->get_type()->is_integer_type()) {
                right = builder->create_sitofp(right, FLOAT_T);
            }
            if (node.op == OP_PLUS) {
                return builder->create_fadd(left, right);
            } else if (node.op == OP_MINUS) {
                return builder->create_fsub(left, right);
            } else {
                assert(0 && "Invalid additive operator");
                return nullptr;
            }
        } else {
            if (node.op == OP_PLUS) {
                return builder->create_iadd(left, right);
            } else if (node.op == OP_MINUS) {
                return builder->create_isub(left, right);
            } else {
                assert(0 && "Invalid additive operator");
                return nullptr;
            }
        }
    }
    return right;
}

Value* CminusfBuilder::visit(ASTTerm &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto right = node.factor->accept(*this);
    if (node.term!= nullptr) {
        auto left = node.term->accept(*this);
        if (left->get_type()->is_float_type() || right->get_type()->is_float_type()) {
            if (left->get_type()->is_integer_type()) {
                left = builder->create_sitofp(left, FLOAT_T);
            }
            if (right->get_type()->is_integer_type()) {
                right = builder->create_sitofp(right, FLOAT_T);
            }
            if (node.op == OP_MUL) {
                return builder->create_fmul(left, right);
            } else if (node.op == OP_DIV) {
                return builder->create_fdiv(left, right);
            } else {
                assert(0 && "Invalid multiplication operator");
                return nullptr;
            }
        } else {
            if (node.op == OP_MUL) {
                return builder->create_imul(left, right);
            } else if (node.op == OP_DIV) {
                return builder->create_isdiv(left, right);
            } else {
                assert(0 && "Invalid multiplication operator");
                return nullptr;
            }
        }
    }
    return right;
}

Value* CminusfBuilder::visit(ASTCall &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto call = scope.find(node.id);
    auto func_type = static_cast<FunctionType *>(call->get_type());

    std::vector<Value *> args;
    for (size_t i = 0; i < node.args.size(); ++i) {
        auto arg = node.args[i]->accept(*this);
        if (arg->get_type() != func_type->get_param_type(i)) {
            if (func_type->get_param_type(i)->is_float_type() && arg->get_type()->is_integer_type()) {
                arg = builder->create_sitofp(arg, FLOAT_T);
            } else if (func_type->get_param_type(i)->is_integer_type() && arg->get_type()->is_float_type()) {
                arg = builder->create_fptosi(arg, INT32_T);
            } else if (func_type->get_param_type(i)->is_integer_type() && arg->get_type()->is_integer_type()) {
               arg = builder->create_zext(arg, func_type->get_param_type(i));
            } else if (arg->get_type()->is_pointer_type() && func_type->get_param_type(i)->is_pointer_type()) {
                if (arg->get_type()->get_pointer_element_type()->is_array_type()) {
                    arg = builder->create_gep(arg, {CONST_INT(0), CONST_INT(0)});
                }

            } else {
                assert(0 && "Unsupported argument type conversion");
                return nullptr;
            }
        }
        args.push_back(arg);
    }

    return builder->create_call(call, args);
}
