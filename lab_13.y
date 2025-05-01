%{
#include <stdio.h>
#include <stdlib.h>

typedef enum { typeNum, typeOp } nodeTypeEnum;

typedef struct ast {
    nodeTypeEnum type;
    union {
        int value; // for NUM
        struct {
            int op; // PLUS, MINUS, etc.
            struct ast *left;
            struct ast *right;
        } opr;
    };
} AST;

AST* createNumNode(int value);
AST* createOpNode(int op, AST* left, AST* right);
void freeAST(AST* node);
void generateCode(AST* node);

int yylex(void);
void yyerror(const char *s);
%}

%union {
    int num;
    AST* node;
}

%token NUM
%token PLUS MINUS MUL DIV LPAREN RPAREN
%type <node> expr

%%

stmt: expr {
    printf("Generating code...\n");
    generateCode($1);
    freeAST($1);
    printf("Done.\n");
};

expr: expr PLUS expr    { $$ = createOpNode(PLUS, $1, $3); }
    | expr MINUS expr   { $$ = createOpNode(MINUS, $1, $3); }
    | expr MUL expr     { $$ = createOpNode(MUL, $1, $3); }
    | expr DIV expr     { $$ = createOpNode(DIV, $1, $3); }
    | LPAREN expr RPAREN { $$ = $2; }
    | NUM               { $$ = createNumNode($1); };

%%

AST* createNumNode(int value) {
    AST* node = malloc(sizeof(AST));
    node->type = typeNum;
    node->value = value;
    return node;
}

AST* createOpNode(int op, AST* left, AST* right) {
    AST* node = malloc(sizeof(AST));
    node->type = typeOp;
    node->opr.op = op;
    node->opr.left = left;
    node->opr.right = right;
    return node;
}

void freeAST(AST* node) {
    if (!node) return;
    if (node->type == typeOp) {
        freeAST(node->opr.left);
        freeAST(node->opr.right);
    }
    free(node);
}

void generateCode(AST* node) {
    if (!node) return;

    if (node->type == typeNum) {
        printf("PUSH %d\n", node->value);
    } else {
        generateCode(node->opr.left);
        generateCode(node->opr.right);

        switch (node->opr.op) {
            case PLUS:  printf("ADD\n"); break;
            case MINUS: printf("SUB\n"); break;
            case MUL:   printf("MUL\n"); break;
            case DIV:   printf("DIV\n"); break;
        }
    }
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter expression:\n");
    yyparse();
    return 0;
}
