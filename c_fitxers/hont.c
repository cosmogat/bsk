/* hont.c */
/* 20-03-2008 */
/* versio 1.1*/
#include <stdio.h>
#define N 100
#define M 600
#define P 10

typedef float matriuReal[N][M];
typedef struct { 
  char nom[P];
} nomPartit;


void escriureMatriu (int fil, int col, matriuReal m);
void calcularHont(int nPartits, int nEscons, matriuReal mat);
void escriureEscons(int tam, nomPartit aux[], matriuReal mat);
void grafic(int tam);


int main() {
  /* Dades */
  int nPar, nEsc;
  matriuReal hont;
  nomPartit nomsPartits[N];
  /* Variables internes */
  int i, j;

  printf("\033[01;38m------------ LLEI D' HONT ------------\n\n\n");
  printf("\033[01;33mQuants partits es presenten?\n");
  scanf(" %d", &nPar);

  for (i = 1; i <= nPar; i++){
    printf("\t\033[01;34mIntrodueix el nom del partit n%d\n\t", i);
    scanf(" %s", nomsPartits[i].nom);
  }

  printf("\n\033[01;32mQuants escons es disputen?\n");
  scanf(" %d", &nEsc);

  for(i = 1; i <= nPar; i++){
    printf("\t\033[01;34mVots del %s?\n\t", nomsPartits[i].nom);
    scanf(" %f", &hont[i][1]);
  }

  calcularHont(nPar, nEsc, hont);
  escriureEscons(nPar, nomsPartits, hont);
  printf("\033[01;38m---------------------------------------\n\n");
}

void escriureMatriu (int fil, int col, matriuReal m){
  int i, j;

  printf("M\n=\n");
  for (i = 1; i < fil; i++) {
    printf ("|");
    for (j = 0; j < (col - 1); j++) {
      printf ("%.2f   ", m[i][j]);
    }
    printf ("%.2f|\n", m[i][col - 1]);
  }
}

void calcularHont(int nPartits, int nEscons, matriuReal mat){
  int i, j, aux1, aux2, contador = 0;
  float major;

  /* Les divisions */
  for(i = 1; i <= nPartits; i++){
    mat[i][0] = 0;
    for(j = 1; j <= nEscons; j++){
      mat[i][j] = mat[i][1] / j;
    }
  }

  /* Realitza els calculs i desa en la columna 0 els escons de cada partit */
  while(contador != nEscons){
    major = 0;
    for (i = 1; i <= nPartits; i++){
      for (j = 1; j <= nEscons; j++){
	if (mat[i][j] > major){
	  major = mat[i][j];
	  aux1 = i;
	  aux2 = j;
	}
      }
    }
    mat[aux1][0] = mat[aux1][0] + 1;
    mat[aux1][aux2] = 0;
    contador++;
  }
}

void escriureEscons(int tam, nomPartit aux[], matriuReal mat){
  int i;

  printf("\033[01;37m\n-------- Escons --------\n");
  for(i = 1; i <= tam; i++){
    printf("\033[01;35m%s: \033[01;36m%0.0f \n", aux[i].nom, mat[i][0]);
    grafic(mat[i][0]);
  }
  printf("\033[01;37m------------------------\n");
}

void grafic(int tam){
  int i;
  for(i = 1; i <= tam; i++){
    printf("\033[01;33m#");
  }
  printf("\n");
}

/*--------------------------*/
/*----------Colors----------*/
/*\033[01;30m ->  Gris fort */
/*\033[01;31m ->  Roig clar */
/*\033[01;32m ->  Verd      */
/*\033[01;33m ->  Groc      */
/*\033[01;34m ->  Blau fosc */
/*\033[01;35m ->  Rosa      */
/*\033[01;36m ->  Turquesa  */
/*\033[01;37m ->  Blanc     */
/*\033[01;38m ->  Roig fort */
/*--------------------------*/
