/* 29-06-2013 */
/* billy */
/* mcd.c */
/* càlcul del màxim comú divisor emprant l'algorisme d'Euclides */
#include <stdio.h>
#include <stdlib.h>


int main (int num_arg, char * vec_arg[]) {
  int a, b, c;
  if (num_arg != 3)
    return -1;
  b = atoi(vec_arg[1]);
  c = atoi(vec_arg[2]);
  if ((b <= 0) || (c <= 0))
    return -2;
  while (c != 0) {
    a = b;
    b = c;
    c = a % b;
  }
  printf("%d\n", b);
  return 0;
}
