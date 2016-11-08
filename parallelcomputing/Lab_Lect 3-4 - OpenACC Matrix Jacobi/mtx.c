#include <stdio.h>
#include <stdlib.h>                    
#include <omp.h>

double **dmatrix(int, int);
void free_dmatrix(double **);

int main(int argc, char *argv[]) {
   double **a, **b, **c, sum;
   long i, j, k, N;
   double t_start, t_end;

   N = 1500;
   a = dmatrix(N, N);
   b = dmatrix(N, N);
   c = dmatrix(N, N);
   
   for (i=0; i < N; i++)
      for (j=0; j < N; j++) {
         a[i][j] = (double)(i+j);
         b[i][j] = (double)(i-j);
     }     

   t_start = omp_get_wtime();

   //#pragma omp parallel for shared(a, b, c, N) private(i, j, k, sum)
  #pragma acc data copyin(a[0:N][0:N],b[0:N][0:N]) copy(c[0:N][0:N])
    {
             # pragma acc region 
             {
                    #pragma acc loop independent vector(16)
                    for (i = 0; i < N; i++) {
                            #pragma acc loop independent vector(16)
                            for (j = 0; j < N; j++) {
                                     for (k = 0; k < N; k++) {
               							  sum += a[i][k] * b[k][j];
             						 }
             							c[i][j] = sum;
                            }
                    }
             }
    }
   

   t_end = omp_get_wtime();

   printf("%10ld %20.15lf\n", N, t_end - t_start);  

   free_dmatrix(c);
   free_dmatrix(b);
   free_dmatrix(a);

   return 0;
}

// allocates a double matrix with range [0..m-1][0..n-1]
double **dmatrix(int m, int n) {
   double **a;
   int i, j;

   a    = (double **) malloc(m   * sizeof(double *));
   a[0] = (double  *) malloc(m*n * sizeof(double  ));
   for (i=1; i < m; i++)
      a[i] = a[i-1] + n;

   return a;
}

// frees a matrix allocated with dmatrix
void free_dmatrix(double **a) {
   free(a[0]);
   free(a);
}