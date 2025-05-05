%{
#include "post_to_inf.tab.h"
#include <stdlib.h>
void yyerror(const char *s);
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[ \t]       ; /* skip whitespace */
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return TIMES; }
"/"         { return DIVIDE; }
"^"         { return POWER; }
"\n"        { return '\n'; }
.           { yyerror("Invalid character"); }

%%

int yywrap(void) {
    return 1;
}