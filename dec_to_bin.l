%{
#include "dec_to_bin.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+            { yylval = atoi(yytext); return NUMBER; }
[ \t]+            ; // Ignore whitespace
\r?\n             { return EOL; }
.                 { fprintf(stderr, "Invalid character: %s\n", yytext); }

%%

int yywrap(void) { return 1; }
