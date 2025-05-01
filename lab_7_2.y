%{
    #include <stdio.h>
    #include <stdlib.h>

    int yylex();
    void yyerror(const char *s);
%}

%token IDENTIFIER
%left '|'   
%left '&'  
%left EQUAL NOTEQUAL 
%right '!' 
%nonassoc '(' ')'


%%

exp:    exp '&' exp_2      { printf("exp -> exp & exp_2\n"); }
    |   exp_2              { printf("exp -> exp_2\n"); }
    ;

exp_2:  exp_3 '|' exp_2    { printf("exp_2 -> exp_3 | exp_2\n"); }
    |   exp_3              { printf("exp_2 -> exp_3\n"); }
    ;

exp_3:  exp_4 EQUAL exp_4   { printf("exp_3 -> exp_4 == exp_4\n"); }
    |   exp_4 NOTEQUAL exp_4   { printf("exp_3 -> exp_4 != exp_4\n"); }
    |   exp_4              { printf("exp_3 -> exp_4\n"); }
    ;


exp_4:  '!' exp_5          { printf("exp_5 -> ! exp_5\n"); } 
    |   exp_5              { printf("exp_4 -> exp_5\n"); }
    ;

exp_5:  IDENTIFIER         { printf("exp_5 -> IDENTIFIER\n"); }
    |   '(' exp ')'        { printf("exp_5 -> ( exp )\n"); }
    ;

%%

int main() {
    printf("Enter a boolean expression:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

