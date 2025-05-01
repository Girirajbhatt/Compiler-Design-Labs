%{
    #include "y.tab.h"
    extern int fraction_flag;
    extern double fraction_div;
%}

%%

[ \t]        ;    // Ignore spaces and tabs
\n           { return 0; }  // Stop parsing on newline
"0"          { return '0'; }
"1"          { return '1'; }
"\."        { fraction_flag = 1; fraction_div = 2.0; return DOT; } 
.            { return 0; }  // Stop on invalid input

%%

int yywrap() { return 1; }


