#include <stdio.h>

int main() {
    int n;
    unsigned long long factorial = 1;

    printf("Enter a number to find its factorial: ");
    scanf("%d", &n);

    // Check for negative input
    if (n < 0) {
        printf("Factorial is not defined for negative numbers.\n");
    } else {
        for (int i = 1; i <= n; i++) {
            factorial *= i;  // Multiply current value of i
        }
        printf("Factorial of %d = %llu\n", n, factorial);
    }

    return 0;
}
