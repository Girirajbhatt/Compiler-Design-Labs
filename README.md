# 📘 Compiler Design Laboratory Manual

This repository contains comprehensive lab work for Compiler Design using tools like **FLEX (Lex)** and **YACC**. The labs focus on various stages of compiler construction, including lexical analysis, parsing, semantic analysis, and code generation.

---

## 📂 Lab Index

1. [Compilation Artifacts](#lab-1-compilation-artifacts)
2. [Lexical Analyzer in C](#lab-2-lexical-analyzer-basic)
3. [Lexical Analyzer using FLEX](#lab-3-lexical-analyzer-using-flex-advanced)
4. [Text Analysis & Expression Validation](#lab-4-text-analysis-and-expression-validation-using-flex)
5. [Introduction to YACC](#lab-5-introduction-to-yacc)
6. [Grammar Design and Parsing](#lab-6-grammar-design-and-parsing)
7. [Expression Parsing and Evaluation](#lab-7--8-expression-parsing-and-evaluation)
8. [Research-based Project Implementation](#lab-9--10-research-based-project-implementation)
9. [Semantic Analysis with YACC](#lab-11-semantic-analysis-using-yacc)
10. [Semantic Actions & TAC](#lab-12-semantic-actions-and-tac-generation)
11. [Code Generation](#lab-13-code-generation)

---

## ✅ Lab 1: Compilation Artifacts

**Objective:**  
Identify and study the different types of files created during the compilation and execution of a C program.

---

## ✅ Lab 2: Lexical Analyzer (Basic)

**Objective:**  
Write a C program to identify tokens such as:
- Keywords (`for`, `while`, `if`)
- Identifiers
- Operators (`+`, `-`, `++`)
- Separators (`;`, `,`)

---

## ✅ Lab 3: Lexical Analyzer using FLEX (Advanced)

**Objective:**  
Create a `LEX` program to identify:
- Keywords, Identifiers, Operators, Literals (INT, FLOAT, REAL)
- Separators, Preprocessor Directives
- Storage Classes (`auto`, `static`, `extern`)
- Comments (single and multi-line)
- Escape Sequences

**References:**
- [MIT FLEX Guide](http://web.mit.edu/gnu/doc/html/flex_1.html)
- [FLEX Tutorial](http://alumni.cs.ucr.edu/~lgao/teaching/flex.html)
- [IIT-Hyderabad Notes](https://people.iith.ac.in/ramakrishna/Compilers-Aug14/doc/flex.pdf)

---

## ✅ Lab 4: Text Analysis and Expression Validation using FLEX

### Part A: Text Analyzer
Count and identify:
- Lines, Words, Capital Letters, Small Letters
- Numbers and Digits
- Special Characters and Delimiters
- Relational Operators and Total Characters

### Part B: Expression Validator
Validate and evaluate a mathematical expression using BODMAS rules.

---

## ✅ Lab 5: Introduction to YACC

**Objective:**
- Study YACC tool and its integration with LEX
- Write a YACC program to validate arithmetic expressions

**Helpful Links:**
- [POSIX YACC Manual](https://pubs.opengroup.org/onlinepubs/009604599/utilities/yacc.html)
- [Lex & YACC Setup](https://faculty.ksu.edu.sa/sites/default/files/lex_and_yacc_installation.pdf)

---

## ✅ Lab 6: Grammar Design and Parsing

1. Validate **C declarative statements**.
2. Validate **arithmetic, relational, and logical expressions** using YACC grammar.

---

## ✅ Lab 7 & 8: Expression Parsing and Evaluation

### 1. Desk Calculator

**Grammar:**
```
exp -> exp addop term | term
addop -> + | -
term -> term mulop factor | factor
mulop -> *
factor -> (exp) | number
number -> number digit | digit
digit -> 0-9
```

- Parse and evaluate expressions like `(2 + (3 * 4))`.

### 2. Boolean Expression Parser

Parse expressions using:
- Operators: `&`, `|`, `!`, `==`, `!=`
- Brackets and Identifiers

### 3. Binary to Decimal Conversion

**Grammar:**
```
S -> L.L | L
L -> LB | B
B -> 0 | 1
```


- Convert binary like `101.101` to decimal `5.625`.

---

## ✅ Lab 9 & 10: Research-based Project Implementation

**Objective:**
Implement AQL Lexer & Parser.

- Follow [AQL Specification](https://specifications.openehr.org/releases/QUERY/latest/AQL.html)
- Submit `.l` (LEX) and `.y` (YACC) files implementing first two compiler phases

---

## ✅ Lab 11: Semantic Analysis using YACC

**Tasks:**
1. Check **balanced parentheses** and count matches.
2. Convert **infix to postfix** using semantic actions.

---

## ✅ Lab 12: Semantic Actions and TAC Generation

1. Extend calculator grammar to:
   - Evaluate expression
   - Generate **Three Address Code (TAC)**
   - Show parse sequence for `(2 + (3 * 4))`

2. Evaluate function-like expressions:
(+ 6 12 18) // Output: 36
(* 2 3 4) // Output: 24
(max 20 10 30) // Output: 30
(min 2 4 3 1) // Output: 1


---

## ✅ Lab 13: Code Generation

**Objective:**  
Generate **machine-level code** or intermediate code from Abstract Syntax Tree (AST) created by the parser.

---


