%{
#include <stdio.h>
#include <ctype.h>
int yylex(void);
void yyerror(char *);
%}

%token NUMBER
%token PLUS MINUS TIMES DIVIDE POWER
%token LPAREN RPAREN

%left PLUS MINUS
%left TIMES DIVIDE
%left POWER
%left UMINUS

%%

input:    /* empty */
        | input line {return 0;}
;

line:     '\n'
        | expr '\n'  { printf("\n"); }
;

expr:     NUMBER          { printf("%d ", $1); }
        | LPAREN expr RPAREN  /* parentheses */
        | expr PLUS expr      { printf("+ "); }
        | expr MINUS expr     { printf("- "); }
        | expr TIMES expr      { printf("* "); }
        | expr DIVIDE expr    { printf("/ "); }
        | expr POWER expr      { printf("^ "); }
        | MINUS expr %prec UMINUS { printf("- "); } /* unary minus */
;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}