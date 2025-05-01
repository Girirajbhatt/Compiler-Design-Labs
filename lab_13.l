%{
#include "y.tab.h"
%}

%%

[0-9]+      { yylval.num = atoi(yytext); return NUM; }
"+"         return PLUS;
"-"         return MINUS;
"*"         return MUL;
"/"         return DIV;
"("         return LPAREN;
")"         return RPAREN;
[ \t\n]     ; // ignore whitespace
.           { printf("Invalid character: %s\n", yytext); return -1; }

%%

int yywrap() {
    return 1;
}
