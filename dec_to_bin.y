%{
#include <stdio.h>
void yyerror(const char *);
int yylex(void);

void print_binary(int n) {
    if (n == 0) {
        printf("0");
        return;
    }
    if (n > 1)
        print_binary(n / 2);
    printf("%d", n % 2);
}
%}

%token NUMBER EOL

%%

line:
    NUMBER EOL {
        printf("%d -> ", $1);
        print_binary($1);
        printf("\n");
    }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter decimal numbers (press Enter after each):\n");
    while (!feof(stdin)) {
        printf("> ");
        yyparse();
    }
    return 0;
}
