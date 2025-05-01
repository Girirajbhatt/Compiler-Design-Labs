%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token ID KEY SEMICOLON NUM

%%

stmt : list SEMICOLON { printf("\nValid Declaration\n"); }
     | error SEMICOLON { printf("\nInvalid Declaration\n"); yyerrok; };

list : KEY vars { }
     ;

vars : vars ',' ID
     | vars ',' array
     | ID
     | array
     ;

array : ID '[' NUM ']' { }
      | ID '[' NUM error { printf("\nError: Missing closing bracket in array declaration\n"); exit(0); }
      | ID '[' ']' { printf("\nError: Array size cannot be empty\n"); exit(0); }
      | ID '[' ID ']' { printf("\nError: Array size must be an integer\n"); exit(0); }
      ;

%%

int main() {
    printf("Enter a declarative statement: ");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("Invalid statement.\n");
    exit(1);
}
