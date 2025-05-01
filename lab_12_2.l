%{
#include "y.tab.h"
%}

%%

[ \t\n]+             ; // skip whitespace

[0-9]+               {
                        yylval.val = atoi(yytext);
                        return NUMBER;
                    }

"("                  return '(';
")"                  return ')';
"+"                  return PLUS;
"*"                  return MUL;
"min"                return MIN;
"max"                return MAX;

.                    { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
