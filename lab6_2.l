%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

extern int yylval;
int val;
%}

%%

[a-zA-Z][a-zA-Z0-9]* { printf("\n Enter the value of variable %s: ", yytext); scanf("%d", &val); 
    yylval = val; return ID; }
[0-9]+(\.[0-9]+)? { yylval = strtod(yytext, NULL); return NUM; }
"<="   { return LE; }
">="   { return GE; }
"=="   { return EQ; }
"!="   { return NE; }
"<"    { return LT; }
">"    { return GT; }
";"    { return SEMICOLON; }
[ \t]+ ;  // Ignore whitespace
\n     { return 0; }
.      { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
