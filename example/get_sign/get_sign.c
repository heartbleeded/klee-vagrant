#include<klee/klee.h>
#include<string.h>

#define MAGIC "magic"

int guess_secret(char* guess) {
  int i;
  for(i=0; i<strlen(MAGIC); i++) {
    if(guess[i] != MAGIC[i])
      return -1;
  }
  return 1;
}

int main() {
  // int a;
  // klee_make_symbolic(&a, sizeof(a), "a");

  char* guess = "?????";
  klee_make_symbolic(guess, strlen(MAGIC)+1, "guess");
  if(guess_secret(guess) == 0) {
    klee_assert(0);
    return 1;
  } else {
    return 0;
  }

  // return get_sign(0);
}




int get_sign(int input) {
  if(input > 0) {
    return +1;
  } else if(input < 0) {
    return -1;
  } else {
    return 0;
  }
}


