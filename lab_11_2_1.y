%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int yylex();
int yyerror(char* s);
extern char* yytext;

char* final_result;
%}

%union {
    char* str;
}

%token <str> NUM ID
%left '+' '-'
%left '*' '/'
%right '^'
%type <str> E T F P

%%

E : E '+' T {
      char* res = malloc(strlen($1) + strlen($3) + 3);
      sprintf(res, "%s %s +", $1, $3);
      $$ = res;
      final_result = res;
    }
  | E '-' T {
      char* res = malloc(strlen($1) + strlen($3) + 3);
      sprintf(res, "%s %s -", $1, $3);
      $$ = res;
      final_result = res;
    }
  | T { $$ = $1; final_result = $1; }
  ;

T : T '*' F {
      char* res = malloc(strlen($1) + strlen($3) + 3);
      sprintf(res, "%s %s *", $1, $3);
      $$ = res;
      final_result = res;
    }
  | T '/' F {
      char* res = malloc(strlen($1) + strlen($3) + 3);
      sprintf(res, "%s %s /", $1, $3);
      $$ = res;
      final_result = res;
    }
  | F { $$ = $1; final_result = $1; }
  ;

F : P '^' F {
      char* res = malloc(strlen($1) + strlen($3) + 3);
      sprintf(res, "%s %s ^", $1, $3);
      $$ = res;
      final_result = res;
    }
  | P { $$ = $1; final_result = $1; }
  ;

P : '(' E ')' {
      $$ = $2;
    }
  | NUM {
      $$ = strdup($1);
    }
  | ID {
      $$ = strdup($1);
    }
  ;

%%

int yyerror(char* s) {
    fprintf(stderr, "Parse error: %s\n", s);
    return 0;
}

int main() {
    if (yyparse() == 0) {
        printf("Postfix expression: %s\n", final_result);
    }
    return 0;
}
