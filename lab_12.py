class ThreeAddressCodeGenerator:
    def __init__(self):
        self.temp_counter = 0
        self.instructions = []

    def new_temp(self):
        """Generate a new temporary variable."""
        self.temp_counter += 1
        return f"t{self.temp_counter}"

    def generate(self, expression):
        """Generate three-address code for an arithmetic expression."""
        # Remove spaces for easier parsing
        expression = expression.replace(" ", "")
        result = self._generate_tac(expression)
        return result

    def _generate_tac(self, expression):
        """Recursive function to generate TAC for a sub-expression."""
        # Base case: single number or variable
        if expression.isalnum():
            return expression

        # Check if the expression is fully enclosed in parentheses
        if expression[0] == '(' and expression[-1] == ')':
            # Remove the outer parentheses and process the inner expression
            return self._generate_tac(expression[1:-1])

        # Find the main operator in the current expression
        operator, left, right = self._split_expression(expression)

        # Generate TAC for the left and right sub-expressions
        left_result = self._generate_tac(left)
        right_result = self._generate_tac(right)

        # Generate a new temporary variable and emit the instruction
        temp = self.new_temp()
        self.instructions.append(f"{temp} = {left_result} {operator} {right_result}")
        return temp

    def _split_expression(self, expression):
        operators = set("+-*/")
        stack = []
        for i in range(len(expression) - 1, -1, -1):  # Traverse from right to left
            if expression[i] == ')':
                stack.append(')')
            elif expression[i] == '(':
                if stack:  # Ensure stack is not empty before popping
                    stack.pop()
            elif expression[i] in operators and not stack:
                # Main operator found (outside any parentheses)
                return expression[i], expression[:i], expression[i + 1:]
        # If no operator is found, check for fully enclosed parentheses
        if expression[0] == '(' and expression[-1] == ')':
            return self._split_expression(expression[1:-1])
        # If we reach here, the expression is invalid
        raise ValueError(f"Invalid expression: {expression}")

    def get_instructions(self):
        """Return the generated TAC instructions."""
        return self.instructions

# Example usage
if __name__ == "__main__":
    expression = "(a + b) * (c - d) / e"

    generator = ThreeAddressCodeGenerator()
    result = generator.generate(expression)
    instructions = generator.get_instructions()

    print("Three-Address Code:")
    for instr in instructions:
        print(instr)