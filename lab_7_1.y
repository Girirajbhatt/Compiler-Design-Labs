%{
    #include <stdio.h>
    #include <stdlib.h>

    int yylex();
    void yyerror(const char *s);
    int result;
%}

%token NUMBER
%left '+' '-'
%left '*'
%nonassoc '(' ')'

%%

exp:    exp '+' term       { printf("exp -> exp + term\n"); $$ = $1 + $3; result = $$; }
    |   exp '-' term       { printf("exp -> exp - term\n"); $$ = $1 - $3; result = $$; }
    |   term               { printf("exp -> term\n"); result = $$; }
    ;

term:   term '*' factor    { printf("term -> term * factor\n"); $$ = $1 * $3; }
    |   factor             { printf("term -> factor\n"); $$ = $1; }
    ;

factor: '(' exp ')'        { printf("factor -> (exp)\n"); $$ = $2; }
    |   NUMBER             { printf("factor -> NUMBER\n"); $$ = $1; }
    ;

%%

int main() {
    printf("Enter an arithmetic expression: ");
    if (yyparse() == 0) {
        printf("Final Evaluated Result: %d\n", result);
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

