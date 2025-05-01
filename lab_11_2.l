%{
#include "y.tab.h"
#include <string.h>
%}

%%

[0-9]+      {
                yylval.str = strdup(yytext);
                return NUM;
            }

"+"         { return '+'; }
"*"         { return '*'; }
"("         { return '('; }
")"         { return ')'; }

[\t\n ]+    ; // Ignore spaces, tabs, newlines

.           { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
