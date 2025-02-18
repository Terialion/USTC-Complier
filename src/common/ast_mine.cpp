#include "ast.hpp"

#include <cstring>
#include <iostream>
#include <stack>

#define _AST_NODE_ERROR_                                                       \
  std::cerr << "Abort due to node cast error."                                 \
               "Contact with TAs to solve your problem."                       \
            << std::endl;                                                      \
  std::abort();
// NOTE: use std::string instead of strcmp to compare strings,
// 注意使用这里的接口
#define _STR_EQ(a, b) (strcmp((a), (b)) == 0)

void AST::run_visitor(ASTVisitor &visitor) { root->accept(visitor); }

AST::AST(syntax_tree *s) {
  if (s == nullptr) {
    std::cerr << "empty input tree!" << std::endl;
    std::abort();
  }
  auto node = transform_node_iter(s->root);
  del_syntax_tree(s);
  root = std::shared_ptr<ASTProgram>(static_cast<ASTProgram *>(node));
}

ASTNode *AST::transform_node_iter(syntax_tree_node *n) {
  /*
  example:
  program -> declaration-list
  declaration-list -> declaration-list declaration | declaration
  将其转化成AST中ASTProgram的结构
  */
  if (_STR_EQ(n->name, "program")) {
    auto node = new ASTProgram();
    // flatten declaration list
    std::stack<syntax_tree_node *>
        s; // 为什么这里要用stack呢？如果用其他数据结构应该如何实现
    auto list_ptr = n->children[0];
    while (list_ptr->children_num == 2) {
      s.push(list_ptr->children[1]);
      list_ptr = list_ptr->children[0];
    }
    s.push(list_ptr->children[0]);

    while (!s.empty()) {
      auto child_node =
          static_cast<ASTDeclaration *>(transform_node_iter(s.top()));

      auto child_node_shared = std::shared_ptr<ASTDeclaration>(child_node);
      node->declarations.push_back(child_node_shared);
      s.pop();
    }
    return node;
  } else if (_STR_EQ(n->name, "declaration")) {
    return transform_node_iter(n->children[0]);
  } else if (_STR_EQ(n->name, "var-declaration")) {
    auto node = new ASTVarDeclaration();
    // NOTE: 思考 ASTVarDeclaration的结构，需要填充的字段有哪些
    // type
    // 为什么不会有 TYPE_VOID?
    if (_STR_EQ(n->children[0]->children[0]->name, "int"))
      node->type = TYPE_INT;
    else
      node->type = TYPE_FLOAT;
    // id & num
    // 由不同的表达式填充
    if (n->children_num == 3) {
      node->id = n->children[1]->name;
    } else if (n->children_num == 6) {
      node->id = n->children[1]->name;
      int num = std::stoi(n->children[3]->name);
      auto num_node = std::make_shared<ASTNum>();
      num_node->i_val = num;
      num_node->type = TYPE_INT;
      node->num = num_node;
    } else {
      std::cerr << "[ast]: var-declaration transform failure!" << std::endl;
      std::abort();
    }
    return node;
  } else if (_STR_EQ(n->name, "fun-declaration")) {
    // fun-declaration -> type-specifier ID ( params ) compound-stmt
    // 由表达式和 ASTFunDeclaration的结构，我们需要填充
    // type, id, params, compound_stmt 这四个字段
    auto node = new ASTFunDeclaration();
    // type 字段填充
    if (_STR_EQ(n->children[0]->children[0]->name, "int")) {
      node->type = TYPE_INT;
    } else if (_STR_EQ(n->children[0]->children[0]->name, "float")) {
      node->type = TYPE_FLOAT;
    } else {
      node->type = TYPE_VOID;
    }
    // id 字段填充
    node->id = n->children[1]->name;

    /*
        params 字段填充
        注意这里的params是一个列表，每个元素都是一个ASTParam，需要flatten
        params -> param-list | void
        param-list -> param-list , param | param
    */
    // TODO: 1.fill in the fields of ASTFunDeclaration
    // 1.1 flatten params
    if (!_STR_EQ(n->children[3]->children[0]->name, "void")) {
      std::stack<syntax_tree_node *> s;
      auto list_ptr = n->children[3]->children[0];
      while (list_ptr->children_num == 3) {
          s.push(list_ptr->children[2]);
          list_ptr = list_ptr->children[0];
      }
      s.push(list_ptr->children[0]);

      while (!s.empty()) {
        auto param_node = static_cast<ASTParam *>(transform_node_iter(s.top()));
        auto param_node_shared = std::shared_ptr<ASTParam>(param_node);
        node->params.push_back(param_node_shared);
        s.pop();
      }
    }
    // 1.2 compound_stmt 字段填充
       node->compound_stmt = std::shared_ptr<ASTCompoundStmt>(
            static_cast<ASTCompoundStmt *>(transform_node_iter(n->children[5])));
    return node;
  } else if (_STR_EQ(n->name, "param")) {
    // param -> type-specifier ID | type-specifier ID [ ]
    // ASTParam的结构 主要需要填充的属性有 type, id, isarray
    auto node = new ASTParam();
    // type, id, isarray
    if (_STR_EQ(n->children[0]->children[0]->name, "int"))
      node->type = TYPE_INT;
    else
      node->type = TYPE_FLOAT;
    node->id = n->children[1]->name;
    if (n->children_num > 2)
      node->isarray = true;
    return node;
  } else if (_STR_EQ(n->name, "compound-stmt")) {
    auto node = new ASTCompoundStmt();
    // TODO: 2.fill in the fields of ASTCompoundStmt
    /*
      文法表达式如下
      compound-stmt -> { local-declarations statement-list }
      local-declarations -> local-declarations var-declaration | empty
      statement-list -> statement-list statement | empty
    */
    // local declarations
    // 2.1 flatten local declarations
    std::stack<syntax_tree_node *> s;
    auto local_declarations_ptr = n->children[1];
    while (local_declarations_ptr->children_num == 2) {
      s.push(local_declarations_ptr->children[1]);
      local_declarations_ptr = local_declarations_ptr->children[0];
    }

    while (!s.empty()) {
      auto var_decl_node = static_cast<ASTVarDeclaration *>(transform_node_iter(s.top()));
      auto var_declarations_node_shared = std::shared_ptr<ASTVarDeclaration>(var_decl_node);
      node->local_declarations.push_back(var_declarations_node_shared);
      s.pop();
    }

    // statement list
    // 2.2 flatten statement-list
    auto statement_list_ptr = n->children[2];
    while (statement_list_ptr->children_num == 2) {
      s.push(statement_list_ptr->children[1]);
      statement_list_ptr = statement_list_ptr->children[0];
    }

    while (!s.empty()) {
      auto stmt_node = static_cast<ASTStatement *>(transform_node_iter(s.top()));
      auto statement_list_node_shared = std::shared_ptr<ASTStatement>(stmt_node);
      node->statement_list.push_back(statement_list_node_shared);
      s.pop();
    }

    return node;
  } else if (_STR_EQ(n->name, "statement")) {
    return transform_node_iter(n->children[0]);
  } else if (_STR_EQ(n->name, "expression-stmt")) {
    auto node = new ASTExpressionStmt();
    if (n->children_num == 2) {
      auto expr_node =
          static_cast<ASTExpression *>(transform_node_iter(n->children[0]));

      auto expr_node_ptr = std::shared_ptr<ASTExpression>(expr_node);
      node->expression = expr_node_ptr;
    }
    return node;
  } else if (_STR_EQ(n->name, "selection-stmt")) {
    auto node = new ASTSelectionStmt();
    // TODO: 5.fill in the fields of ASTSelectionStmt
    /*
      selection-stmt -> if ( expression ) statement | if ( expression )
      statement else statement ASTSelectionStmt的结构，需要填充的字段有
      expression, if_statement, else_statement
    */
    // 5.1 expresstion
    auto expr_node = static_cast<ASTExpression *>(
        transform_node_iter(n->children[2]));
    auto expr_node_ptr = std::shared_ptr<ASTExpression>(expr_node);
    node->expression = expr_node_ptr;
    // 5.2 if statement
    auto if_stmt_node = static_cast<ASTStatement *>(
        transform_node_iter(n->children[4]));
    auto if_stmt_node_ptr = std::shared_ptr<ASTStatement>(if_stmt_node);
    node->if_statement = if_stmt_node_ptr;
    // check whether this selection statement contains
    // 5.3 else structure
    if (n->children_num == 7) {
      auto else_stmt_node = static_cast<ASTStatement *>(
          transform_node_iter(n->children[6]));
      auto else_stmt_node_ptr = std::shared_ptr<ASTStatement>(else_stmt_node);
      node->else_statement = else_stmt_node_ptr;
    }
    return node;
  } else if (_STR_EQ(n->name, "iteration-stmt")) {
    auto node = new ASTIterationStmt();

    auto expr_node =
        static_cast<ASTExpression *>(transform_node_iter(n->children[2]));
    auto expr_node_ptr = std::shared_ptr<ASTExpression>(expr_node);
    node->expression = expr_node_ptr;

    auto stmt_node =
        static_cast<ASTStatement *>(transform_node_iter(n->children[4]));
    auto stmt_node_ptr = std::shared_ptr<ASTStatement>(stmt_node);
    node->statement = stmt_node_ptr;

    return node;
  } else if (_STR_EQ(n->name, "return-stmt")) {
    auto node = new ASTReturnStmt();
    if (n->children_num == 3) {
      auto expr_node =
          static_cast<ASTExpression *>(transform_node_iter(n->children[1]));
      node->expression = std::shared_ptr<ASTExpression>(expr_node);
    }
    return node;
  } else if (_STR_EQ(n->name, "expression")) {
    // simple-expression
    if (n->children_num == 1) {
      return transform_node_iter(n->children[0]);
    }
    auto node = new ASTAssignExpression();

    auto var_node = static_cast<ASTVar *>(transform_node_iter(n->children[0]));
    node->var = std::shared_ptr<ASTVar>(var_node);

    auto expr_node =
        static_cast<ASTExpression *>(transform_node_iter(n->children[2]));
    node->expression = std::shared_ptr<ASTExpression>(expr_node);

    return node;
  } else if (_STR_EQ(n->name, "var")) {
    auto node = new ASTVar();
    node->id = n->children[0]->name;
    if (n->children_num == 4) {
      auto expr_node =
          static_cast<ASTExpression *>(transform_node_iter(n->children[2]));
      node->expression = std::shared_ptr<ASTExpression>(expr_node);
    }
    return node;
  } else if (_STR_EQ(n->name, "simple-expression")) {
    auto node = new ASTSimpleExpression();
    auto expr_node_1 = static_cast<ASTAdditiveExpression *>(
        transform_node_iter(n->children[0]));
    node->additive_expression_l =
        std::shared_ptr<ASTAdditiveExpression>(expr_node_1);

    if (n->children_num == 3) {
      auto op_name = n->children[1]->children[0]->name;
      if (_STR_EQ(op_name, "<="))
        node->op = OP_LE;
      else if (_STR_EQ(op_name, "<"))
        node->op = OP_LT;
      else if (_STR_EQ(op_name, ">"))
        node->op = OP_GT;
      else if (_STR_EQ(op_name, ">="))
        node->op = OP_GE;
      else if (_STR_EQ(op_name, "=="))
        node->op = OP_EQ;
      else if (_STR_EQ(op_name, "!="))
        node->op = OP_NEQ;

      auto expr_node_2 = static_cast<ASTAdditiveExpression *>(
          transform_node_iter(n->children[2]));
      node->additive_expression_r =
          std::shared_ptr<ASTAdditiveExpression>(expr_node_2);
    }
    return node;
  } else if (_STR_EQ(n->name, "additive-expression")) {
    auto node = new ASTAdditiveExpression();
    if (n->children_num == 3) {
      // TODO: 4.fill in the fields of ASTAdditiveExpression
      /*
        文法表达式如下
        additive-expression -> additive-expression addop term | term 
      */
      // additive_expression, term, op
      auto additive_expression_node =
          static_cast<ASTAdditiveExpression *>(transform_node_iter(n->children[0]));
      node->additive_expression = std::shared_ptr<ASTAdditiveExpression>(additive_expression_node);

      auto op_name = n->children[1]->children[0]->name;
      if (_STR_EQ(op_name, "+"))
        node->op = OP_PLUS;
      else if (_STR_EQ(op_name, "-"))
        node->op = OP_MINUS;
      auto term_node =
          static_cast<ASTTerm *>(transform_node_iter(n->children[2]));
      node->term = std::shared_ptr<ASTTerm>(term_node);
    } else {
      auto term_node =
          static_cast<ASTTerm *>(transform_node_iter(n->children[0]));
      node->term = std::shared_ptr<ASTTerm>(term_node);
    }
    return node;
  } else if (_STR_EQ(n->name, "term")) {
    auto node = new ASTTerm();
    if (n->children_num == 3) {
      auto term_node =
          static_cast<ASTTerm *>(transform_node_iter(n->children[0]));
      node->term = std::shared_ptr<ASTTerm>(term_node);

      auto op_name = n->children[1]->children[0]->name;
      if (_STR_EQ(op_name, "*"))
        node->op = OP_MUL;
      else if (_STR_EQ(op_name, "/"))
        node->op = OP_DIV;

      auto factor_node =
          static_cast<ASTFactor *>(transform_node_iter(n->children[2]));
      node->factor = std::shared_ptr<ASTFactor>(factor_node);
    } else {
      auto factor_node =
          static_cast<ASTFactor *>(transform_node_iter(n->children[0]));
      node->factor = std::shared_ptr<ASTFactor>(factor_node);
    }
    return node;
  } else if (_STR_EQ(n->name, "factor")) {
    int i = 0;
    if (n->children_num == 3)
      i = 1;
    auto name = n->children[i]->name;
    if (_STR_EQ(name, "expression") || _STR_EQ(name, "var") ||
        _STR_EQ(name, "call"))
      return transform_node_iter(n->children[i]);
    else {
      auto num_node = new ASTNum();
      // TODO: 3.fill in the fields of ASTNum
      /*
        文法表达式如下
        factor -> ( expression ) | var | call | integer | float
        float -> FLOATPOINT
        integer -> INTEGER
      */
      if (_STR_EQ(name, "integer")) {
        // 3.1
        num_node->type = TYPE_INT;
        num_node->i_val = std::stoi(n->children[i]->children[0]->name);
      } else if (_STR_EQ(name, "float")) {
        // 3.2
        num_node->type = TYPE_FLOAT;
        num_node->f_val = std::stof(n->children[i]->children[0]->name);
      } else {
        _AST_NODE_ERROR_
      }
      return num_node;
    }
  } else if (_STR_EQ(n->name, "call")) {
    auto node = new ASTCall();
    node->id = n->children[0]->name;
    // flatten args
    if (_STR_EQ(n->children[2]->children[0]->name, "arg-list")) {
      auto list_ptr = n->children[2]->children[0];
      auto s = std::stack<syntax_tree_node *>();
      while (list_ptr->children_num == 3) {
        s.push(list_ptr->children[2]);
        list_ptr = list_ptr->children[0];
      }
      s.push(list_ptr->children[0]);

      while (!s.empty()) {
        auto expr_node =
            static_cast<ASTExpression *>(transform_node_iter(s.top()));
        auto expr_node_ptr = std::shared_ptr<ASTExpression>(expr_node);
        node->args.push_back(expr_node_ptr);
        s.pop();
      }
    }
    return node;
  } else {
    std::cerr << "[ast]: transform failure!" << std::endl;
    std::abort();
  }
}

Value* ASTProgram::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTNum::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTVarDeclaration::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTFunDeclaration::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTParam::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTCompoundStmt::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTExpressionStmt::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTSelectionStmt::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTIterationStmt::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTReturnStmt::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTAssignExpression::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTSimpleExpression::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTAdditiveExpression::accept(ASTVisitor &visitor) {
    return visitor.visit(*this);
}
Value* ASTVar::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTTerm::accept(ASTVisitor &visitor) { return visitor.visit(*this); }
Value* ASTCall::accept(ASTVisitor &visitor) { return visitor.visit(*this); }

#define _DEBUG_PRINT_N_(N)                                                     \
    { std::cout << std::string(N, '-'); }

Value* ASTPrinter::visit(ASTProgram &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "program" << std::endl;
    add_depth();
    for (auto decl : node.declarations) {
        decl->accept(*this);
    }
    remove_depth();
    return nullptr;
}

Value* ASTPrinter::visit(ASTNum &node) {
    _DEBUG_PRINT_N_(depth);
    if (node.type == TYPE_INT) {
        std::cout << "num (int): " << node.i_val << std::endl;
    } else if (node.type == TYPE_FLOAT) {
        std::cout << "num (float): " << node.f_val << std::endl;
    } else {
        _AST_NODE_ERROR_
    }
    return nullptr;
}

Value* ASTPrinter::visit(ASTVarDeclaration &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "var-declaration: " << node.id;
    if (node.num != nullptr) {
        std::cout << "[]" << std::endl;
        add_depth();
        node.num->accept(*this);
        remove_depth();
        return nullptr;
    }
    std::cout << std::endl;
    return nullptr;
}

Value* ASTPrinter::visit(ASTFunDeclaration &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "fun-declaration: " << node.id << std::endl;
    add_depth();
    for (auto param : node.params) {
        param->accept(*this);
    }

    node.compound_stmt->accept(*this);
    remove_depth();
    return nullptr;
}

Value* ASTPrinter::visit(ASTParam &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "param: " << node.id;
    if (node.isarray)
        std::cout << "[]";
    std::cout << std::endl;
    return nullptr;
}

Value* ASTPrinter::visit(ASTCompoundStmt &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "compound-stmt" << std::endl;
    add_depth();
    for (auto decl : node.local_declarations) {
        decl->accept(*this);
    }

    for (auto stmt : node.statement_list) {
        stmt->accept(*this);
    }
    remove_depth();
    return nullptr;
}

Value* ASTPrinter::visit(ASTExpressionStmt &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "expression-stmt" << std::endl;
    add_depth();
    if (node.expression != nullptr)
        node.expression->accept(*this);
    remove_depth();
    return nullptr;
}

Value* ASTPrinter::visit(ASTSelectionStmt &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "selection-stmt" << std::endl;
    add_depth();
    node.expression->accept(*this);
    node.if_statement->accept(*this);
    if (node.else_statement != nullptr)
        node.else_statement->accept(*this);
    remove_depth();
    return nullptr;
}

Value* ASTPrinter::visit(ASTIterationStmt &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "iteration-stmt" << std::endl;
    add_depth();
    node.expression->accept(*this);
    node.statement->accept(*this);
    remove_depth();
    return nullptr;
}

Value* ASTPrinter::visit(ASTReturnStmt &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "return-stmt";
    if (node.expression == nullptr) {
        std::cout << ": void" << std::endl;
    } else {
        std::cout << std::endl;
        add_depth();
        node.expression->accept(*this);
        remove_depth();
    }
    return nullptr;
}

Value* ASTPrinter::visit(ASTAssignExpression &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "assign-expression" << std::endl;
    add_depth();
    node.var->accept(*this);
    node.expression->accept(*this);
    remove_depth();
    return nullptr;
}

Value* ASTPrinter::visit(ASTSimpleExpression &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "simple-expression";
    if (node.additive_expression_r == nullptr) {
        std::cout << std::endl;
    } else {
        std::cout << ": ";
        if (node.op == OP_LT) {
            std::cout << "<";
        } else if (node.op == OP_LE) {
            std::cout << "<=";
        } else if (node.op == OP_GE) {
            std::cout << ">=";
        } else if (node.op == OP_GT) {
            std::cout << ">";
        } else if (node.op == OP_EQ) {
            std::cout << "==";
        } else if (node.op == OP_NEQ) {
            std::cout << "!=";
        } else {
            std::abort();
        }
        std::cout << std::endl;
    }
    add_depth();
    node.additive_expression_l->accept(*this);
    if (node.additive_expression_r != nullptr)
        node.additive_expression_r->accept(*this);
    remove_depth();
    return nullptr;
}

Value* ASTPrinter::visit(ASTAdditiveExpression &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "additive-expression";
    if (node.additive_expression == nullptr) {
        std::cout << std::endl;
    } else {
        std::cout << ": ";
        if (node.op == OP_PLUS) {
            std::cout << "+";
        } else if (node.op == OP_MINUS) {
            std::cout << "-";
        } else {
            std::abort();
        }
        std::cout << std::endl;
    }
    add_depth();
    if (node.additive_expression != nullptr)
        node.additive_expression->accept(*this);
    node.term->accept(*this);
    remove_depth();
    return nullptr;
}

Value* ASTPrinter::visit(ASTVar &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "var: " << node.id;
    if (node.expression != nullptr) {
        std::cout << "[]" << std::endl;
        add_depth();
        node.expression->accept(*this);
        remove_depth();
        return nullptr;
    }
    std::cout << std::endl;
    return nullptr;
}

Value* ASTPrinter::visit(ASTTerm &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "term";
    if (node.term == nullptr) {
        std::cout << std::endl;
    } else {
        std::cout << ": ";
        if (node.op == OP_MUL) {
            std::cout << "*";
        } else if (node.op == OP_DIV) {
            std::cout << "/";
        } else {
            std::abort();
        }
        std::cout << std::endl;
    }
    add_depth();
    if (node.term != nullptr)
        node.term->accept(*this);

    node.factor->accept(*this);
    remove_depth();
    return nullptr;
}

Value* ASTPrinter::visit(ASTCall &node) {
    _DEBUG_PRINT_N_(depth);
    std::cout << "call: " << node.id << "()" << std::endl;
    add_depth();
    for (auto arg : node.args) {
        arg->accept(*this);
    }
    remove_depth();
    return nullptr;
}
