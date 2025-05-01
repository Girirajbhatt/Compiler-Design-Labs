%{
#include "y.tab.h"
%}

%%

"("         return LPAREN;
")"         return RPAREN;
"a"         return A;
[ \t]+      ;    // ignore whitespace
\n          return 0;  // end of input on newline
.           { printf("Invalid character: %s\n", yytext); return -1; }

%%

int yywrap() {
    return 1;
}
