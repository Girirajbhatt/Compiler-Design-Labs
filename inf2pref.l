%{
#include "inf2pref.tab.h"
#include <stdlib.h>
#include <string.h>
#define MAX_LEN 100
%}

%%
[0-9]+    { strncpy(yylval.str, yytext, MAX_LEN); return NUMBER; }
[ \t]+    ;  /* Skip whitespace */
\n        return '\n';
[-+*/^()] return yytext[0];
.         { yyerror("Unknown character"); return 0; }
%%

int yywrap() {
    return 1;
}