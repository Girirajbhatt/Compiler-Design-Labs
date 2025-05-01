%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

int operators_count = 0, operands_count = 0, valid = 1, top = -1, operand_top = -1;
char operator_stack[100];
int operand_stack[100];

int precedence(char op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    return 0;
}
%}

%%

"(" {
    operator_stack[++top] = '(';
}

")" {
    while (top >= 0 && operator_stack[top] != '(') {
        char op = operator_stack[top--];
        int b = operand_stack[operand_top--];
        int a = operand_stack[operand_top--];
        int result;

        switch(op) {
            case '+': result = a + b; break;
            case '-': result = a - b; break;
            case '*': result = a * b; break;
            case '/':
                if (b == 0) {
                    printf("Error: Division by zero!\n");
                    valid = 0;
                    return 0;
                }
                result = a / b;
                break;
        }
        operand_stack[++operand_top] = result;
    }
    if (top >= 0) top--;
    else valid = 0;
}

[+\-*/] {
    while (top >= 0 && precedence(operator_stack[top]) >= precedence(yytext[0])) {
        char op = operator_stack[top--];
        int b = operand_stack[operand_top--];
        int a = operand_stack[operand_top--];
        int result;

        switch(op) {
            case '+': result = a + b; break;
            case '-': result = a - b; break;
            case '*': result = a * b; break;
            case '/':
                if (b == 0) {
                    printf("Error: Division by zero!\n");
                    valid = 0;
                    return 0;
                }
                result = a / b;
                break;
        }
        operand_stack[++operand_top] = result;
    }
    operator_stack[++top] = yytext[0];
    operators_count++;
}

[0-9]+ {
    operand_stack[++operand_top] = atoi(yytext);
    operands_count++;
}

[\t ] ;

\n {
    while (top >= 0) {
        char op = operator_stack[top--];
        int b = operand_stack[operand_top--];
        int a = operand_stack[operand_top--];
        int result;

        switch(op) {
            case '+': result = a + b; break;
            case '-': result = a - b; break;
            case '*': result = a * b; break;
            case '/':
                if (b == 0) {
                    printf("Error: Division by zero!\n");
                    valid = 0;
                    return 0;
                }
                result = a / b;
                break;
        }
        operand_stack[++operand_top] = result;
    }
    return 0;
}

. {
    valid = 0;
}

%%

int main() {
    printf("Enter the arithmetic expression: ");
    yylex();

    if (valid && operands_count > operators_count + 1) {
        printf("\nInvalid Expression: Too many operands\n");
    } else if (valid && operands_count <= operators_count) {
        printf("\nInvalid Expression: Too many operators\n");
    } else if (valid) {
        printf("\nValid Expression\n");
        if (operand_top >= 0) {
            printf("Result: %d\n", operand_stack[operand_top]);
        }
    } else {
        printf("\nInvalid Expression\n");
    }
    return 0;
}

int yywrap() {
    return 1;
}
