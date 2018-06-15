/* 04-06-2010 */
/* billy */

#include <stdio.h>
#include <stdlib.h>

int main (int num_arg, char * vec_arg[]) {
  int i;
  float mitja = 0.0;

  if (num_arg == 1) {
    fprintf(stderr, "0\n");
    exit (-1);
  }

  for (i = 1; i < num_arg; i++)
    mitja += atof(vec_arg[i]);

  mitja /= (num_arg - 1);
  fprintf(stdout, "%f\n", mitja);

  return (0);
}
