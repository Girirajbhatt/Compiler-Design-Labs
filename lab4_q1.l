%{
#include <stdio.h>

int line_count = -1, word_count = 0, capital_count = 0, small_count = 0;
int number_count = 0, digit_count = 0, special_count = 0, delimiter_count = 0;
int relational_count = 0, char_count = 0;
int last_was_newline = 0; // Track consecutive newlines
%}

/* Matches single digits (0-9) */
DIGIT   [0-9]

/* Matches numbers like 10, 21 */
NUMBER  [1-9][0-9]*   

CAPITAL [A-Z]
SMALL   [a-z]
SPECIAL [!@#$%^&*()_+={}\[\]:;\"'<>,.?/|\\`~]
DELIMITER [ ,\t]
REL_OP  (<|<=|>|>=|==|!=|<|>)

%%

\n       { 
            line_count++; 
            char_count++; 
            if (last_was_newline) return 0; // Stop on double Enter
            last_was_newline = 1; 
         }
{DELIMITER}+  { delimiter_count++; word_count++; char_count += yyleng; last_was_newline = 0; }
{CAPITAL}  { capital_count++; char_count++; last_was_newline = 0; }
{SMALL}    { small_count++; char_count++; last_was_newline = 0; }
{DIGIT}    { digit_count++; char_count++; last_was_newline = 0; }
{NUMBER}   { number_count++; digit_count += yyleng; char_count += yyleng; last_was_newline = 0; }
{SPECIAL}  { special_count++; char_count++; last_was_newline = 0; }
{REL_OP}   { relational_count++; char_count += yyleng; last_was_newline = 0; }
.          { char_count++; last_was_newline = 0; }

%%

int main() {
    printf("Enter text (Press Enter twice to stop input):\n");
    yylex();

    printf("\nStatistics:\n");
    
    printf("Lines: %d\n", line_count);
    printf("Words: %d\n", word_count);
    printf("Capital Letters: %d\n", capital_count);
    printf("Small Letters: %d\n", small_count);
    printf("Numbers: %d\n", number_count);
    printf("Digits: %d\n", digit_count);
    printf("Special Characters: %d\n", special_count);
    printf("Delimiters: %d\n", delimiter_count);
    printf("Relational Operators: %d\n", relational_count);
    printf("Total Characters: %d\n", char_count);

    return 0;
}

int yywrap() {
    return 1;
}