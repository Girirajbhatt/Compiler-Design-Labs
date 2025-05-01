%{
#include "y.tab.h"
%}

%%

[0-9]     {
              yylval.val = yytext[0] - '0';
              return DIGIT;
          }

[ \t\n]   ;  // Skip whitespace

[+\-*() ] return yytext[0];  // Single char operators and parentheses

.         {
              printf("Invalid character: %s\n", yytext);
          }

%%

int yywrap() {
    return 1;
}
