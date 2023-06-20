#include "cs136.h"

// half_add(a, b) calculates a/2 + b/2
int half_add(int a, int b) {
  int c;
  if (a > 0 && b > 0) {
    return c = (a / 2) + (b / 2) + ((a % 2) && (b % 2));
  } else if (a < 0 && b < 0) {
    return c = (a / 2) + (b / 2) - ((a % 2) && (b % 2));
  } else {
    return c = (a / 2) + (b / 2);
  }
}

// half_sub(a, b) calculates a/2 - b/2
int half_sub(int a, int b) {
  int c;
  if (a > 0 && b < 0) {
    return c = (a / 2) - (b / 2) + ((a % 2) && (b % 2));
  } else if (a < 0 && b > 0) {
    return c = (a / 2) - (b / 2) - ((a % 2) && (b % 2));
  } else {
    return c = (a / 2) - (b / 2);
  }
}

// will_add_overflow(a, b) determines whether a+b will overflow or not
bool will_add_overflow(int a, int b) {
  if (b > INT_MAX || b < INT_MIN) {
    return true;
  }
  int c = half_add(a, b);
  if ((a > 0 && b > 0) || (a < 0 && b < 0)) {
    if (((abs(a) % 2 == 0) && (abs(b) % 2 == 1)) || 
      ((abs(a) % 2 == 1) && (abs(b) % 2 == 0))) {
    c--;
    }
  }
  if (c > INT_MAX / 2 || c < INT_MIN / 2) {
    return true;
  } else {
    return false;
  }
}

// will_sub_overflow(a, b) determines whether a-b will overflow or not
bool will_sub_overflow(int a, int b) {
  if (b > INT_MAX || b < INT_MIN) {
    return true;
  }
  int c = half_sub(a, b);
  if ((a > 0 && b < 0) || (a < 0 && b > 0)) {
    if (((abs(a) % 2 == 0) && (abs(b) % 2 == 1)) || 
      ((abs(a) % 2 == 1) && (abs(b) % 2 == 0))) {
    c--;
    }
  }
  if (c > INT_MAX / 2 || c < INT_MIN / 2) {
    return true;
  } else {
    return false;
  }
}

// wil_mult_overflow(a, b) determines whether a*b will overflow or not
bool will_mult_overflow(int a, int b) {
  if (a > 0 && b > 0 && a > INT_MAX / b) {
    return true;
  } else if (a > 0 && b < 0 && b < INT_MIN / a) {
    return true;
  } else if (a < 0 && b > 0 && a < INT_MIN / b) {
    return true;
  } else if (a < 0 && b < 0 && a != 0 && b < INT_MAX / a) {
    return true;
  } else {
  return false;
  }
}

// will_div_overflow(a, b) determines whether a/b will overflow or not
bool will_div_overflow(int a, int b) {
  if (a == INT_MIN && b == -1) {
    return true;
  } else {
    return false;
  }
}

// add_calculate(current, value) calculate current+value
int add_calculate(int current, int value) {
  if (will_add_overflow(current, value)) {
    printf("OVERFLOW\n");
    exit(EXIT_SUCCESS);
  } else {
    int sum = current + value;
    printf("%d\n", sum);
    return sum;
  }
}

// sub_calculate(current, value) calculate current-value
int sub_calculate(int current, int value) {
  if (will_sub_overflow(current, value)) {
    printf("OVERFLOW\n");
    exit(EXIT_SUCCESS);
  } else {
    int diff = current - value;
    printf("%d\n", diff);
    return diff;
  }
}

// mult_calculate(current, value) calculate current*value
int mult_calculate(int current, int value) {
  if (will_mult_overflow(current, value)) {
    printf("OVERFLOW\n");
    exit(EXIT_SUCCESS);
  } else {
    int prod = current * value;
    printf("%d\n", prod);
    return prod;
  }
}

// div_calculate(current, value) calculate current/value
int div_calculate(int current, int value) {
  if (value == 0) {
    printf("DIVIDE BY ZERO\n");
    exit(EXIT_SUCCESS);
  } else if (will_div_overflow(current, value)) {
    printf("OVERFLOW\n");
    exit(EXIT_SUCCESS);
  } else {
    int quot = current / value;
    printf("%d\n", quot);
    return quot;
  }
}

///////////////////////////////////////////////////////////////////////////// 
// Do not modify this function

// You MUST use this function to read in an int from input

// read_int_or_exit() reads in an integer from input, or exits (terminates)
//   the program if an int cannot be successfully read in
// note: terminates the program quietly with no output displayed
// effects: reads input
//          may terminate program (a rare side effect we don't normally
//                                 worry about in this course)
int read_int_or_exit(void) {
  int input = 0;
  if (scanf("%d", &input) != 1) {
    exit(EXIT_SUCCESS);
  }
  return input;
}
/////////////////////////////////////////////////////////////////////////////

int main(void) {
  int ADD = lookup_symbol("add");
  int SUB = lookup_symbol("sub");
  int MULT = lookup_symbol("mult");
  int DIV = lookup_symbol("div");
  int current = 0;
  while (1) {
    int oper = read_symbol();
    int value = read_int_or_exit();
    if (oper == ADD) {
      int final_result = add_calculate(current, value);
      current = final_result;
    } else if (oper == SUB) {
      int final_result = sub_calculate(current, value);
      current = final_result;
    } else if (oper == MULT) {
      int final_result = mult_calculate(current, value);
      current = final_result;
    } else if (oper == DIV) {
      int final_result = div_calculate(current, value);
      current = final_result;
    } else {
      exit(EXIT_SUCCESS);
    }
  }
}