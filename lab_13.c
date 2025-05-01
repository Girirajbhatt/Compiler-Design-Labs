#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define node types for the AST
typedef enum {
    NODE_NUMBER,
    NODE_BINARY_OP
} NodeType;

// Define operators for binary operations
typedef enum {
    OP_ADD,
    OP_SUB,
    OP_MUL,
    OP_DIV
} OperatorType;

// Abstract Syntax Tree Node
typedef struct Node {
    NodeType type;
    union {
        // For number nodes
        int value;
        // For binary operation nodes
        struct {
            struct Node *left;
            OperatorType operator;
            struct Node *right;
        } binary_op;
    };
} Node;

// Function to create a number node
Node* create_number_node(int value) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->type = NODE_NUMBER;
    node->value = value;
    return node;
}

// Function to create a binary operation node
Node* create_binary_op_node(Node* left, OperatorType operator, Node* right) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->type = NODE_BINARY_OP;
    node->binary_op.left = left;
    node->binary_op.operator = operator;
    node->binary_op.right = right;
    return node;
}

// Recursive function to generate code from the AST
void generate_code(Node* node) {
    if (node->type == NODE_NUMBER) {
        printf("PUSH %d\n", node->value);
    } else if (node->type == NODE_BINARY_OP) {
        generate_code(node->binary_op.left);
        generate_code(node->binary_op.right);
        switch (node->binary_op.operator) {
            case OP_ADD:
                printf("ADD\n");
                break;
            case OP_SUB:
                printf("SUB\n");
                break;
            case OP_MUL:
                printf("MUL\n");
                break;
            case OP_DIV:
                printf("DIV\n");
                break;
        }
    }
}

// Function to free the AST
void free_ast(Node* node) {
    if (node->type == NODE_BINARY_OP) {
        free_ast(node->binary_op.left);
        free_ast(node->binary_op.right);
    }
    free(node);
}

// Main function demonstrating the use of the code generator
int main() {
    // Build the AST for the expression (3 + 5) * 2
    Node* ast = create_binary_op_node(
        create_binary_op_node(
            create_number_node(3),
            OP_ADD,
            create_number_node(5)
        ),
        OP_MUL,
        create_number_node(2)
    );

    // Generate machine code
    printf("Generated Machine Code:\n");
    generate_code(ast);

    // Free the AST
    free_ast(ast);

    return 0;
}