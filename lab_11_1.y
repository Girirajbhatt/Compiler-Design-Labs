%{
#include <stdio.h>
#include <stdlib.h>

int count = 0;
int yylex(void);
void yyerror(const char* s);
%}

%token LPAREN RPAREN A

%%

S: Expr {
    printf("Parentheses are balanced.\n");
    printf("Matching pairs: %d\n", count);
}
;

Expr: Expr Element {
    // allows multiple (a)(a) style
}
    | Element
;

Element: LPAREN Expr RPAREN {
    count++;
    printf("Matched: ( Expr ) | count = %d\n", count);
}
      | A {
    printf("Matched: A\n");
}
;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Enter string:\n");
    yyparse();
    return 0;
}
