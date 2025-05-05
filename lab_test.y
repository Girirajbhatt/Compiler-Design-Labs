%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* linear[100];
int count = 0;

void yyerror(const char *s);
int yylex();
%}

%union {
    char* str;
}

%token <str> ID NUM
%token COMMA LPAREN RPAREN
%type <str> element

%%

input:
    LPAREN list RPAREN {
        printf("linear representation: ");
        for(int i = 0; i < count; i++)
            printf("%s ", linear[i]);
        printf("\n");

        printf("reverse representation: ");
        for(int i = count - 1; i >= 0; i--)
            printf("%s ", linear[i]);
        printf("\n");

        printf("count: %d\n", count);
    }
;

list:
    element_list
;

element_list:
    element
    | element_list COMMA element
;

element:
    ID     { linear[count++] = $1; }
    | NUM  { linear[count++] = $1; }
    | LPAREN list RPAREN { /* Group, no direct element */ }
;

;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}