%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
%}

%%

[a-zA-Z][a-zA-Z0-9]* { 
    printf("\nEnter the value of variable %s: ", yytext);
    double val;
    scanf("%lf", &val);
    yylval.dval = val;  // Use yylval.dval instead of redefining yylval
    
    return id; 
}

[0-9]+(\.[0-9]+)? { yylval.dval = atof(yytext); return num; }

[ \t]+   /* Ignore spaces and tabs */
\n       /* Ignore newlines */

.        { return yytext[0]; }  /* Return single-character tokens */

%%

int yywrap() {
    return 1;
}

