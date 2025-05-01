%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();  // Explicit declaration for yylex()
void yyerror(char *s);  // Explicit declaration for yyerror()
%}


%union {
    double dval;  // YYSTYPE will use double values
}

%token <dval> id num
%type <dval> expr  /* Specify the type of expr */

%left '+' '-'
%left '*' '/' '%'
%right UMINUS

%%

stmt : expr { printf("\nValid Expression\n"); };

expr : '(' expr ')' { $$ = $2; }
     | expr '+' expr { printf("\nPlus recognized"); $$ = $1 + $3; printf("\nResult: %lf", $$); }
     | expr '-' expr { printf("\nMinus recognized"); $$ = $1 - $3; printf("\nResult: %lf", $$); }
     | expr '*' expr { printf("\nMultiplication recognized"); $$ = $1 * $3; printf("\nResult: %lf", $$); }
     | expr '/' expr { 
         printf("\nDivision recognized"); 
         if ($3 == 0) { printf("\nError: Division by zero!"); exit(1); }
         else { $$ = $1 / $3; printf("\nResult: %lf", $$); }
     }
     | expr '%' expr { printf("\nModulus recognized"); $$ = (int)$1 % (int)$3; printf("\nResult: %lf", $$); }
     | '-' expr %prec UMINUS { $$ = -$2; printf("\nUnary minus applied, Result: %lf", $$); }
     | num { $$ = $1; }
     ;

%%

void yyerror(char *s) {
    fprintf(stderr, "Syntax error: %s\n", s);
}

int main() {
    printf("Enter an arithmetic expression: ");
    yyparse();
    return 0;
}
