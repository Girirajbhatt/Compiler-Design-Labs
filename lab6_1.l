%{
#include "y.tab.h"
#include <stdio.h>
%}

%%

"int"    {return KEY;}
"float"  {return KEY;}
"char"   {return KEY;}
"double" {return KEY;}
"short"  {return KEY;}
"long"   {return KEY;}
[a-zA-Z_][a-zA-Z0-9_]* {return ID;}
[0-9]+   {return NUM;}
"["      {return '[';}
"]"      {return ']';}
","      {return ',';}
";"      {return SEMICOLON;}
[\t ]+   ;  // Ignore whitespace
\n       {return 0;}  // End of input
.        {return yytext[0];}

%%

int yywrap() {
    return 1;
}


