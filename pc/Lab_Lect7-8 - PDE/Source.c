#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <omp.h>
#include <time.h>

//////////////////////////////////////////////////

#define Lx  0.1
#define Ly  0.1

#define N_x  80
#define N_y  80

#define time_steps 100

double **u;
double **u_new;
/////////////////////////////////////////////////

long N_all = (N_x)*(N_y);
                          
void print_to_file(long int, double **);

double **dmatrix(int m, int n) {
   double **a;
   int i;

   a    = (double **) malloc(m   * sizeof(double *));
   a[0] = (double  *) malloc(m*n * sizeof(double  ));
   for (i=1; i < m; i++)
      a[i] = a[i-1] + n;

   return a;
}

void init() {
    int x,y;

	for (x = 0; x < N_x; x++) {
		for (y = 0; y < N_y; y++) {
			//u[x][y] = sinf(x);
			if (x == N_x/2 || y == N_y/2) u[x][y] = -50;
			else u[x][y] = 10; 
		}
	}    
}

double f(int x, int y) {
    return x*x;	    
}

int main(int argc, char* argv[]) { 

    double hx,hy;
	double a,b,c;	
    int iter,x,y;    

    hx = Lx / N_x;
    hy = Ly / N_y;    

	u = dmatrix(N_x,N_y);
	u_new = dmatrix(N_x,N_y);    

    //***********/ initial condition /***************
	init();    

	a = 2*(1/(hx*hx) + 1/(hy*hy));
	b = 1/(hx*hx);
	c = 1/(hy*hy);	
    //**************************
    
	//***********/ boundary condition /***************
	for(x = 0; x < N_x; x++) {
		u[x][N_y-1] = 10;
		u[x][0] = 10;
	}
	for(y = 0; y < N_y; y++) {
		u[N_x-1][y] = 10;
		u[0][y] = 10;
	}
	//********************************************

    printf("\n\n ======= Starting iteration ========\n");       	    

	//print_to_file(0, u);		

    //=============================== main cycle start
    for (iter=0; iter < time_steps; iter++) {		

	   #pragma omp parallel for private(x,y,a,b,c) shared(u)
		for(x = 1; x < N_x-1; ++x) {
			for(y = (x%2)+1; y < N_y-1; y+=2) {
				u[x][y] = ((u[x-1][y] + u[x+1][y])*b + (u[x][y-1] + u[x][y+1])*c + f(x,y))/a;
			}
		}

		#pragma omp parallel for private(x,y,a,b,c) shared(u)
		for(x = 1; x < N_x-1; ++x) {
			for(y = ((x+1)%2)+1; y < N_y-1; y+=2) {
				u[x][y] = ((u[x-1][y] + u[x+1][y])*b + (u[x][y-1] + u[x][y+1])*c + f(x,y))/a;
			}
		}     		

        printf("%d step is made... \n" ,iter);
               
		print_to_file(iter, u);		              
    }
    //================================= main cycle end
    printf("Calculations comleted.\n");    

}

void print_to_file(long int n, double **a) {

	int kk=1, i, j;
	FILE *fp;       
	char buf[20];

	  sprintf(buf, "data_%lu.xyz", n/1);

	  fp = fopen(buf, "w"); 
	  if (fp == NULL) {
		 printf("Error opening file!\n");
		 exit(1);
	  }

	  fprintf(fp,"%lu\n", N_all);
      fprintf(fp,"ITEM: ATOMS id xs ys zs\n");


	  for ( i = 0; i < N_x; i++) {          
		  for ( j = 0; j < N_y; j++) {  			  
			   fprintf(fp, "%d %d %d %f\n", kk, i, j, a[i][j]);									
			   kk++;                			  
		  }
      }	 
	  fclose(fp);
}
