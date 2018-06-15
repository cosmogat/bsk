/* 22-11-2013 */
/* billy */
/* str_replace.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int str_subcomp(char * subcadena, char * cadena, int ini);

int main(int num_arg, char * vec_arg[]) {
  int i, pos = 0, tam1, tam2, tam3;
  char * cad, * aux_cad;
 
  if (num_arg != 4)
    return 1;

  tam1 = strlen(vec_arg[1]);
  tam2 = strlen(vec_arg[2]);
  tam3 = strlen(vec_arg[3]);

  cad = (char *) malloc(tam3 * sizeof(char *));
  strcpy(cad, vec_arg[3]);
   
  pos = str_subcomp(vec_arg[1], cad, pos);
  while (pos != -1) {
    aux_cad = (char *) malloc((tam3 - tam1 + tam2) * sizeof(char *));
    for (i = 0; i < pos; i++)
      aux_cad[i] = cad[i];
    int j = 0;
    for (i = pos; i < (pos + tam2); i++) {
      aux_cad[i] = vec_arg[2][j];
      j++;
    }
    j = i - tam2 + tam1;
    for (i = (pos + tam2); i < (tam3 - tam1 + tam2); i++) {
      aux_cad[i] = cad[j];
      j++;
    }
  
    tam3 = tam3 - tam1 + tam2;
    free(cad);
    cad = (char *) malloc(tam3 * sizeof(char *));
    strcpy(cad, aux_cad);
    free(aux_cad);

    pos = str_subcomp(vec_arg[1], cad, pos - tam1 + tam2);
  } 
  printf("%s\n", cad);

  return 0;
}

int str_subcomp(char * subcadena, char * cadena, int ini) {
  /* Torna la posició on comença subcadena dins de cadena, en cas de no trobarla torna -1. L'algorisme comença a partir de la posició ini de cadena */
  int tam_cad = strlen(cadena);
  int tam_sub = strlen(subcadena);
  int i, j = 0;

  if (tam_sub > tam_cad)
    return -1;
  for (i = ini; i < tam_cad; i++) {
    if (cadena[i] == subcadena[j])
      j++;
    else if (cadena[i] == subcadena[0])
      j = 1;
    else
      j = 0;
    if (j == tam_sub)
      return i - tam_sub + 1;
  }
  return -1;
}
