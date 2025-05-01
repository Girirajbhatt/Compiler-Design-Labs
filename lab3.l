%{
#include <stdio.h>
#include <string.h>
#define MAX_IDENTIFIER_LENGTH 30
%}

DIGIT          [0-9]
LETTER         [a-zA-Z]
IDENTIFIER     {LETTER}(_|{LETTER}|{DIGIT})*
KEYWORDS       "break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"float"|"for"|"goto"|"if"|"int"|"long"|"return"|"short"|"signed"|"sizeof"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"
OPERATORS      "+"|"-"|"*"|"/"|"%"|"=="|"!="|">"|"<"|"<="|">="|"&&"|"||"|"!"|"&"|"|"|"^"|"~"|"<<"|">>"|"="|"+="|"-="|"*="|"/="|"%="|"&="|"|="|"^="|"<<="|">>="|"++"|"--"|".*"|"->"|"=>*"
SEPARATORS     ","|";"|"{"|"}"|"("|")"|"["|"]"|"."|":"|"..."
STORAGE_CLASS  "auto"|"register"|"static"|"extern"
ESCAPE_SEQ     "\\n|\\b|\\r|\\f|\\v|\\u|\\0|\\\\|\\t|\\'|\\\""
COMMENTS       "//.*|/\\*([^*]|[*]+[^*/])*\\*/"
PREPROCESSOR   "#[ \t]*[a-zA-Z]+"

%%

{KEYWORDS}          { printf("<KEYWORD> %s\n", yytext); }
{STORAGE_CLASS}      { printf("<STORAGE_CLASS> %s\n", yytext); }
{ESCAPE_SEQ}         { printf("<ESCAPE_SEQUENCE> %s\n", yytext); }
{DIGIT}+"."{DIGIT}+  { printf("<FLOAT_LITERAL> %s\n", yytext); }
{DIGIT}+             { printf("<INT_LITERAL> %s\n", yytext); }
{IDENTIFIER}         {
                        if (strlen(yytext) > MAX_IDENTIFIER_LENGTH)
                            printf("<ERROR: Identifier too long> %s\n", yytext);
                        else
                            printf("<IDENTIFIER> %s\n", yytext);
                     }
{OPERATORS}          { printf("<OPERATOR> %s\n", yytext); }
{SEPARATORS}         { printf("<SEPARATOR> %s\n", yytext); }
{PREPROCESSOR}       { printf("<PREPROCESSOR_DIRECTIVE> %s\n", yytext); }
{COMMENTS}           { printf("<COMMENT>\n"); }
[ \t\n]+             ; /* Ignore whitespaces */
.                    { printf("<UNKNOWN> %s\n", yytext); }

%%

int main() {
    printf("Enter C code: \n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
