%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

/* Declare token types */
%token ID NUM
%token LT GT LE GE EQ NE SEMICOLON

/* Define operator precedence and associativity */
%left LT GT LE GE EQ NE

%%

stmt: expr SEMICOLON { printf("\nValid Relational Expression\n"); }
    | error SEMICOLON { printf("\nInvalid Relational Expression\n"); yyerrok; }
    ;

expr: expr LT expr { printf("\nLess Than Recognized: %d\n", ($$ = $1 < $3)); }
    | expr GT expr { printf("\nGreater Than Recognized: %d\n", ($$ = $1 > $3)); }
    | expr LE expr { printf("\nLess Than or Equal Recognized: %d\n", ($$ = $1 <= $3)); }
    | expr GE expr { printf("\nGreater Than or Equal Recognized: %d\n", ($$ = $1 >= $3)); }
    | expr EQ expr { printf("\nEqual Recognized: %d\n", ($$ = $1 == $3)); }
    | expr NE expr { printf("\nNot Equal Recognized: %d\n", ($$ = $1 != $3)); }
    | '(' expr ')' { $$ = $2; } 
    | ID
    | NUM
    ;

%%

int main() {
    printf("Enter a relational expression followed by ';':\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}
