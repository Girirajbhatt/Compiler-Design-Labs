%{
#include "y.tab.h"
#include <string.h>
#include <ctype.h>
%}

%%

[0-9]+(\.[0-9]+)?    {
                        yylval.str = strdup(yytext);
                        return NUM;
                    }

[a-zA-Z_][a-zA-Z0-9_]* {
                        yylval.str = strdup(yytext);
                        return ID;
                    }

"+"     { return '+'; }
"-"     { return '-'; }
"*"     { return '*'; }
"/"     { return '/'; }
"^"     { return '^'; }
"("     { return '('; }
")"     { return ')'; }

[\t\n ]+    ; // ignore whitespace

.       { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
