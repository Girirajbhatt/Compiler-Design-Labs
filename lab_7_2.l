%{
    #include "y.tab.h"
%}

%%

[ \t]          ;    // Ignore spaces and tabs
\n             { return 0; }  // Return 0 (EOF) to stop parsing on a new line
[a-zA-Z][a-zA-Z0-9]*   { return IDENTIFIER; }
"&"         { return '&'; }
"|"         { return '|'; }
"=="        { return EQUAL; }  
"!="        { return NOTEQUAL; }
"!"         { return '!'; }
"("         { return '('; }
")"         { return ')'; }

%%

int yywrap() { return 1; }

