class Node:
    """Base class for all nodes in the AST."""
    pass

class NumberNode(Node):
    """Represents a number in the AST."""
    def __init__(self, value):
        self.value = value

class BinaryOpNode(Node):
    """Represents a binary operation in the AST."""
    def __init__(self, left, operator, right):
        self.left = left
        self.operator = operator
        self.right = right

class CodeGenerator:
    def __init__(self):
        self.instructions = []

    def generate(self, node):
        """Generate machine code from the AST."""
        if isinstance(node, NumberNode):
            self.instructions.append(f"PUSH {node.value}")
        elif isinstance(node, BinaryOpNode):
            self.generate(node.left)
            self.generate(node.right)
            if node.operator == '+':
                self.instructions.append("ADD")
            elif node.operator == '-':
                self.instructions.append("SUB")
            elif node.operator == '*':
                self.instructions.append("MUL")
            elif node.operator == '/':
                self.instructions.append("DIV")
            else:
                raise ValueError(f"Unknown operator: {node.operator}")
        else:
            raise ValueError(f"Unknown node type: {type(node).__name__}")

    def get_instructions(self):
        """Return the generated instructions."""
        return self.instructions

# Example usage:
if __name__ == "__main__":
    # Representing the expression (3 + 5) * 2 as an AST
    ast = BinaryOpNode(
        left=BinaryOpNode(
            left=NumberNode(3),
            operator='+',
            right=NumberNode(5)
        ),
        operator='*',
        right=NumberNode(2)
    )

    generator = CodeGenerator()
    generator.generate(ast)
    machine_code = generator.get_instructions()

    print("Generated Machine Code:")
    for instruction in machine_code:
        print(instruction)