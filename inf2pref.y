%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_LEN 100

void yyerror(const char *s);
int yylex(void);
%}

%union {
    char str[100];
}

%token <str> NUMBER
%left '+' '-'
%left '*' '/'
%left '^'
%nonassoc UMINUS
%type <str> expr

%%

input:
    expr '\n' { printf("Prefix: %s\n", $1); }
    ;

expr:
    NUMBER {
        strcpy($$, $1);
    }
    | '+' expr expr {
        snprintf($$, MAX_LEN, "+ %s %s", $2, $3);
    }
    | '-' expr expr {
        snprintf($$, MAX_LEN, "- %s %s", $2, $3);
    }
    | '*' expr expr {
        snprintf($$, MAX_LEN, "* %s %s", $2, $3);
    }
    | '/' expr expr {
        snprintf($$, MAX_LEN, "/ %s %s", $2, $3);
    }
    | '^' expr expr {
        snprintf($$, MAX_LEN, "^ %s %s", $2, $3);
    }
    | '-' expr %prec UMINUS {
        snprintf($$, MAX_LEN, "- %s", $2);
    }
    | '(' expr ')' {
        strcpy($$, $2);
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter infix expression (e.g., 3+4*5): ");
    yyparse();
    return 0;
}