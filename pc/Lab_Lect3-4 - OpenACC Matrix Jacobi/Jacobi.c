#include <stdio.h>
#include <omp.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
    int n = 1024;
    int m = 1024;
    int iter_max = 1000;
    
    const float pi  = 2.0f * asinf(1.0f);
    const float tol = 1.0e-5f;
    float error     = 1.0f;
    
    float *restrict A = (float*)malloc(sizeof(float)*n*m);
    float *restrict Anew = (float*)malloc(sizeof(float)*n*m);
    float *restrict y0 = (float*)malloc(sizeof(float)*n);

    memset(A, 0, n * m * sizeof(float));
    
    // set boundary conditions
    for (int i = 0; i < m; i++)
    {
        A[0*m+i]   = 0.f;
        A[(n-1)*m+i] = 0.f;
    }
    
    for (int j = 0; j < n; j++)
    {
        y0[j] = sinf(pi * j / (n-1));
        A[j*m+0] = y0[j];
        A[j*m+m-1] = y0[j]*expf(-pi);
    }
    
    printf("Jacobi relaxation Calculation: %d x %d mesh\n", n, m);
        
    int iter = 0;
    
#pragma omp parallel for shared(Anew)
    for (int i = 1; i < m; i++)
    {
       Anew[0*m+i]   = 0.f;
       Anew[(n-1)*m+i] = 0.f;
    }
#pragma omp parallel for shared(Anew)    
    for (int j = 1; j < n; j++)
    {
        Anew[j*m+0]   = y0[j];
        Anew[j*m+m-1] = y0[j]*expf(-pi);
    }
    
    while ( error > tol && iter < iter_max ) {
        error = 0.f;

    #pragma acc kernels 
    {
        #pragma acc loop independent
        for( int j = 1; j < n-1; j++) {
            for( int i = 1; i < m-1; i++ ) {

                Anew[j*m+i] = 0.25f * ( A[j*m+i+1] + A[j*m+i-1]
                                     + A[(j-1)*m+i] + A[(j+1)*m+i]);

                error = fmaxf( error, fabsf(Anew[j*m+i]-A[j*m+i]));
            }
        }

        #pragma acc loop independent
        for( int j = 1; j < n-1; j++) {
            for( int i = 1; i < m-1; i++ ) {
                A[j*m+i] = Anew[j*m+i];    
            }
        }
    }

        if(iter % 100 == 0) printf("%5d, %0.6f\n", iter, error);
        
        iter++;
    }


}
