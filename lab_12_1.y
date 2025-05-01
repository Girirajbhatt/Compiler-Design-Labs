%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyerror(char* s);
%}

%union {
    int val;
}

%token <val> DIGIT
%type <val> exp term factor number

%%

exp    : exp '+' term {
            printf("Evaluating: %d + %d = %d\n", $1, $3, $1 + $3);
            $$ = $1 + $3;
         }
       | exp '-' term {
            printf("Evaluating: %d - %d = %d\n", $1, $3, $1 - $3);
            $$ = $1 - $3;
         }
       | term {
            $$ = $1;
         }
       ;

term   : term '*' factor {
            printf("Evaluating: %d * %d = %d\n", $1, $3, $1 * $3);
            $$ = $1 * $3;
         }
       | factor {
            $$ = $1;
         }
       ;

factor : '(' exp ')' {
            $$ = $2;
         }
       | number {
            $$ = $1;
         }
       ;

number : number DIGIT {
            $$ = $1 * 10 + $2;
         }
       | DIGIT {
            $$ = $1;
         }
       ;

%%

int yyerror(char* s) {
    printf("Error: %s\n", s);
    return 0;
}

int main() {
    printf("Enter expression:\n");
    yyparse();
    return 0;
}
