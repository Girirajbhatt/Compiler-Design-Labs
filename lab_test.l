%{
#include "lab_test.tab.h"
#include <string.h>
%}

%%
[0-9]+          { yylval.str = strdup(yytext); return NUM; }
[a-zA-Z_]+      { yylval.str = strdup(yytext); return ID; }
","             { return COMMA; }
"("             { return LPAREN; }
")"             { return RPAREN; }
[ \t\n\r]+      { /* skip whitespace */ }
.               { /* ignore other chars */ }

%%
int yywrap() { return 1; }
