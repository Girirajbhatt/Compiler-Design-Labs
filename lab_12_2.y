%{
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int yylex();
int yyerror(char *s);
%}

%union {
    int val;
}

%token <val> NUMBER
%token PLUS MUL MIN MAX
%type <val> expr expr_list_plus expr_list_mul expr_list_min expr_list_max

%%

input   : expr { printf("Result = %d\n", $1); }
        ;

expr    : '(' PLUS expr_list_plus ')' { $$ = $3; }
        | '(' MUL  expr_list_mul  ')' { $$ = $3; }
        | '(' MIN  expr_list_min  ')' { $$ = $3; }
        | '(' MAX  expr_list_max  ')' { $$ = $3; }
        | NUMBER { $$ = $1; }
        ;

expr_list_plus
        : expr expr_list_plus { $$ = $1 + $2; }
        | expr { $$ = $1; }
        ;

expr_list_mul
        : expr expr_list_mul { $$ = $1 * $2; }
        | expr { $$ = $1; }
        ;

expr_list_min
        : expr expr_list_min { $$ = ($1 < $2) ? $1 : $2; }
        | expr { $$ = $1; }
        ;

expr_list_max
        : expr expr_list_max { $$ = ($1 > $2) ? $1 : $2; }
        | expr { $$ = $1; }
        ;

%%

int yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}

int main() {
    printf("Enter prefix expression:\n");
    yyparse();
    return 0;
}
