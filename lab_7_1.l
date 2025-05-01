%{
    #include "y.tab.h"
%}

%%

[ \t]          ;    // Ignore spaces and tabs
\n             { return 0; }  // Return 0 (EOF) to stop parsing on a new line
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[\+\-\*]    { return yytext[0]; }
\(          { return '('; }
\)          { return ')'; }
.           { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() { return 1; }
