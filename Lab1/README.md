# Lab1 Introduction  

In this experiment, students need to build a complete **Cminusf parser** from scratch. This includes a **Flex-based lexical analyzer** and a **Bison-based syntax analyzer**, and then transforming the obtained **syntax tree** into an **Abstract Syntax Tree (AST)**.  

## Documents  

Several documents are provided for this experiment. Please read them carefully according to your progress and needs:  

- **Regular Expressions**  
- **Flex**  
- **Bison**  
- **Lexical and Syntax Analysis**  
- **AST**  
- **AST Generation**  

## Experiment Content  

This experiment is divided into **two phases**, each requiring completion and review.  

### **Phase 1**  

- **Task 1**: Read **Regular Expressions**, **Flex**, and **Bison** to grasp the fundamentals. Then, answer the **reflection questions** in each document and save the responses as `answer.pdf`.  
- **Task 2**: Read **Lexical and Syntax Analysis**, implement the **lexical analyzer** and **syntax analyzer**, and generate the **syntax tree**.  

**Deadline**: September 28, 2024, 23:59  

### **Phase 2**  

- **Task 1**: Read **AST** to understand the transformation logic from a **syntax tree** to an **abstract syntax tree**.  
- **Task 2**: Read **AST Generation**, and complete the construction of the **AST**.  

**Deadline**: October 7, 2024, 23:59  

## Experiment Requirements  

1. **Fork** the experiment repository before starting.  
2. **Use your own forked repository** for all future experiments.  
3. Follow the instructions from **Lab0** to **fork and clone** the experiment repository to your local virtual machine. Then, set the **experiment repository as the upstream repository**.  

```bash
git clone ${Your_Repo}
cd 2024ustc-jianmu-compiler
git checkout lab1
git remote add upstream https://cscourse.ustc.edu.cn/vdir/Gitlab/compiler_staff/2024ustc-jianmu-compiler
git pull upstream lab1
