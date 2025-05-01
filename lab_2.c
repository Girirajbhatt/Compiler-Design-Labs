#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LENGTH 1000

// List of C keywords
const char *keywords[] = {
    "auto", "double", "int", "struct", "break", "else", "long", "switch",
    "case", "enum", "register", "typedef", "char", "extern", "return", "union",
    "const", "float", "short", "unsigned", "continue", "for", "signed", "void",
    "default", "goto", "sizeof", "volatile", "do", "if", "static", "while"
};

// List of C operators
const char *operators[] = {
    "+", "-", "*", "/", "%", 
    "<", ">", "==", "!=", ">=", "<=", 
    "++", "--", 
    "=", "+=", "-=", "*=", "/=", "%=", 
    "&&", "||", "!", 
    "&", "|", "^", "~", "<<", ">>"
};

// List of separators
const char separators[] = {'(', ')', '{', '}', '[', ']', ',', ';', ' ', '\t', '\n'};

// Check if a string is a keyword
bool isKeyword(const char *str) {
    int num_keywords = sizeof(keywords) / sizeof(keywords[0]);
    for (int i = 0; i < num_keywords; i++) {
        if (strcmp(str, keywords[i]) == 0) {
            return true;
        }
    }
    return false;
}

// Check if a string is an operator
bool isOperator(const char *str) {
    int num_operators = sizeof(operators) / sizeof(operators[0]);
    for (int i = 0; i < num_operators; i++) {
        if (strcmp(str, operators[i]) == 0) {
            return true;
        }
    }
    return false;
}

// Check if a character is a separator
bool isSeparator(char ch) {
    for (int i = 0; i < sizeof(separators); i++) {
        if (ch == separators[i]) {
            return true;
        }
    }
    return false;
}

// Check if a string is a valid identifier
bool isValidIdentifier(const char *str) {
    if (!isalpha(str[0]) && str[0] != '_') return false;
    for (int i = 1; str[i] != '\0'; i++) {
        if (!isalnum(str[i]) && str[i] != '_') return false;
    }
    return true;
}

// Get a substring from a string
char *getSubstring(const char *str, int start, int end) {
    int subLength = end - start + 1;
    char *subStr = (char *)malloc((subLength + 1) * sizeof(char));
    strncpy(subStr, str + start, subLength);
    subStr[subLength] = '\0';
    return subStr;
}

// Check if a string is an integer
bool isInteger(const char *str) {
    for (int i = 0; str[i] != '\0'; i++) {
        if (!isdigit(str[i])) return false;
    }
    return true;
}

// Analyze a substring and print its token type
void analyzeSubstring(const char *subStr) {
    if (isKeyword(subStr)) {
        printf("Token: Keyword, Value: %s\n", subStr);
    } else if (isOperator(subStr)) {
        printf("Token: Operator, Value: %s\n", subStr);
    } else if (isInteger(subStr)) {
        printf("Token: Integer, Value: %s\n", subStr);
    } else if (isValidIdentifier(subStr)) {
        printf("Token: Identifier, Value: %s\n", subStr);
    } else {
        printf("Token: Unidentified, Value: %s\n", subStr);
    }
}

// Lexical analyzer function
void lexicalAnalyzer(const char *input) {
    int left = 0, right = 0;
    int len = strlen(input);

    while (right <= len) {
        if (!isSeparator(input[right]) && input[right] != '\0') {
            right++;
        } else {
            if (left < right) {
                char *subStr = getSubstring(input, left, right - 1);
                analyzeSubstring(subStr);
                free(subStr);
            }

            if (isSeparator(input[right]) && input[right] != '\0') {
                if (!isspace(input[right])) {
                    printf("Token: Separator, Value: %c\n", input[right]);
                }
            }

            right++;
            left = right;
        }
    }
}

// Main function
int main() {
    char lex_input[MAX_LENGTH];
    printf("Enter the code snippet: \n");
    fgets(lex_input, sizeof(lex_input), stdin);
    printf("For Expression \"%s\":\n", lex_input);
    lexicalAnalyzer(lex_input);
    printf("\n");
    return 0;
}