%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

#define MAX_STACK 100

// Stack implementation
char stack[MAX_STACK][100];
int top = -1;

void push(const char *s);
const char *pop();
void yyerror(const char *s);
int yylex(void);

%}

%token NUMBER
%token PLUS MINUS TIMES DIVIDE POWER

%left PLUS MINUS
%left TIMES DIVIDE
%left POWER
%left UMINUS

%%

input:    /* empty */
        | input line
;

line:     '\n' { printf("\n"); }
        | expr '\n' { 
            printf("Infix: %s\n", stack[top]); 
            pop();  // Clear the final result from stack
          }
;

expr:     NUMBER { 
            char num[20];
            sprintf(num, "%d", $1);
            push(num);
            printf("Pushed number: %s\n", num);
          }
        | expr expr PLUS { 
            const char *b = pop();
            const char *a = pop();
            char temp[100];
            sprintf(temp, "(%s + %s)", a, b);
            push(temp);
            printf("Applied +: %s\n", temp);
          }
        | expr expr MINUS { 
            const char *b = pop();
            const char *a = pop();
            char temp[100];
            sprintf(temp, "(%s - %s)", a, b);
            push(temp);
            printf("Applied -: %s\n", temp);
          }
        | expr expr TIMES { 
            const char *b = pop();
            const char *a = pop();
            char temp[100];
            sprintf(temp, "(%s * %s)", a, b);
            push(temp);
            printf("Applied *: %s\n", temp);
          }
        | expr expr DIVIDE { 
            const char *b = pop();
            const char *a = pop();
            char temp[100];
            sprintf(temp, "(%s / %s)", a, b);
            push(temp);
            printf("Applied /: %s\n", temp);
          }
        | expr expr POWER { 
            const char *b = pop();
            const char *a = pop();
            char temp[100];
            sprintf(temp, "(%s ^ %s)", a, b);
            push(temp);
            printf("Applied ^: %s\n", temp);
          }
;

%%

void push(const char *s) {
    if (top >= MAX_STACK-1) {
        yyerror("Stack overflow");
        exit(1);
    }
    strcpy(stack[++top], s);
}

const char *pop() {
    if (top < 0) {
        yyerror("Stack underflow");
        exit(1);
    }
    return stack[top--];
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Enter postfix expression (e.g., '3 4 +'):\n");
    yyparse();
    return 0;
}