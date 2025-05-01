%{
#include <stdio.h>
int line_count = 0, word_count = 0, capital_letters = 0, small_letters = 0;
int numbers = 0, digits = 0, special_characters = 0, delimiters = 0, relational_operators = 0;
int total_characters = 0;
%}

UPPER      [A-Z]
LOWER      [a-z]
NUMBER     [0-9]+
SPECIAL    [!@#$%^&_|'"/?`~]
DELIM      [,.;:{}()\[\]]
REL_OP     (==|!=|<=|>=|<|>)
WHITESPACE [ \t]+

%%

\n           { line_count++; total_characters++; }
{UPPER}      { capital_letters++; total_characters++; }
{LOWER}      { small_letters++; total_characters++; }
{NUMBER}     { digits += yyleng; numbers++; total_characters += yyleng; }
{SPECIAL}    { special_characters++; total_characters++; }
{DELIM}      { delimiters++; total_characters++; }
{REL_OP}     { relational_operators++; total_characters += yyleng; }
{WHITESPACE} { word_count++; }  /* Counting words assuming whitespace separates them */
.            { total_characters++; }

%%

int main() {
    printf("Enter text (Press ctrl + Z then press Enter to stop input):\n");
    yylex();

    printf("\nCounts:\n");
    printf("Lines: %d\n", line_count);
    printf("Words: %d\n", word_count);
    printf("Capital Letters: %d\n", capital_letters);
    printf("Small Letters: %d\n", small_letters);
    printf("Numbers: %d\n", numbers);
    printf("Digits: %d\n", digits);
    printf("Special Characters: %d\n", special_characters);
    printf("Delimiters: %d\n", delimiters);
    printf("Relational Operators: %d\n", relational_operators);
    printf("Total Characters: %d\n", total_characters);

    return 0;
}

int yywrap() {
    return 1;
}


