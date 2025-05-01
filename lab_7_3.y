%{
    #include <stdio.h>
    #include <math.h>
    #include <stdlib.h>

    int yylex();
    void yyerror(const char *s);

    double integer_part, fraction_part, fraction_div;
    int fraction_flag;
%}

%token DOT

%%

S: L DOT L   { printf("Decimal Value: %lf\n", integer_part + fraction_part); }
 | L         { printf("Decimal Value: %lf\n", integer_part); }
 ;

L: L B       { 
                if (fraction_flag) {
                    fraction_part += ($2 / fraction_div); 
                    fraction_div *= 2.0;  // Update for next bit
                } else {
                    integer_part = integer_part * 2 + $2;
                }
                
            }
 | B         { 
                if (fraction_flag) {
                    fraction_part += ($1 / fraction_div);
                    fraction_div *= 2.0;
                } else {
                    integer_part = $1;
                }
            }
 ;

B: '0' { $$ = 0; }
 | '1' { $$ = 1; }
 ;

%%

int main() {
    integer_part = 0;
    fraction_part = 0.0;
    fraction_div = 1.0;  // Initialize as 1.0, updated on DOT
    fraction_flag = 0;

    printf("Enter a binary number:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}



