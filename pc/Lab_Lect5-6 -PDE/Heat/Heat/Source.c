#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <omp.h>
#include <time.h>

//////////////////////////////////////////////////

#define T 300

#define Lx  0.1
#define Ly  0.1
#define Lz  0.1

#define grid_x  100
#define grid_y  20
#define grid_z  100

#define dt 1e-7
#define time_steps 100
#define intervals 5

double ***temp;
double ***temp_new;
/////////////////////////////////////////////////

long MAXITER;
long CHUNK;

double ***c;							// grid of the sample

long N_all = (grid_x)*(grid_y)*(grid_z);

                          
void print_to_file(long int, double ***);
void printT(double data[], int data_size, long int n);
void phase(long int);
void phase0();

double ***fmatrix(int nx, int ny, int nz) {
   double ***A;
   int i,j;
   
    A = (double ***)malloc(sizeof(double**) * nx);

    for (i = 0; i < nx; i++) {
         A[i] = (double**)malloc(sizeof(double*) * ny);

        for (j = 0; j < ny; j++) {
	        A[i][j] = (double*)malloc(sizeof(double) * nz);
        } 
    }
    
    return A;
}

void put_inclusion(int x,int y,int z,int radius)
{
    int i,j,k;
    int pi,pj,pk;

    x = x % grid_x;
    y = y % grid_y;
    z = z % grid_z;

    if (radius == 0) temp[x][y][z] = T;
    if (radius > 0)
    {
        for (i=(x-radius); i<=(x+radius); i++)
        {
            for (j=(y-radius); j<=(y+radius); j++)
            {
                for (k=(z-radius); k<=(z+radius); k++)
                {
                    if ( ((i-x)*(i-x) + (j-y)*(j-y) + (k-z)*(k-z)) < radius*radius)
                    {
                        pi = i;
                        pj = j;
                        pk = k;

                        if (i<0)      pi = grid_x + i;
                        if (i>grid_x) pi = i - grid_x;

                        if (j<0)      pj = grid_y + j;
                        if (j>grid_y) pj = j - grid_y;

                        if (k<0)      pk = grid_z + k;
                        if (k>grid_z) pk = k - grid_z;

                        temp[pi][pj][pk] = T;
                    }
                }
            }
        }
    }
}

int main(int argc, char* argv[]) { 

    double dx,dy,dz;
	unsigned long msc = 0;

    int t,i,j,k;    

    dx = Lx / grid_x;
    dy = Ly / grid_y;
    dz = Lz / grid_z;

	temp = fmatrix(grid_x,grid_y,grid_z);
	temp_new = fmatrix(grid_x,grid_y,grid_z);

    for (i=0; i<grid_x; i++) {    
        for (j=0; j<grid_y; j++) {        
            for (k=0; k<grid_z; k++) {            
                temp[i][j][k] = 0.0;
                temp_new[i][j][k] = 0.0;
            }
        }
    }

    //**************************
	put_inclusion(grid_x/2,grid_y/2,grid_z/2,15);    
    //**************************

    for (i=0; i<grid_x; i++) {    
        for (j=0; j<grid_y; j++) {        
            for (k=0; k<grid_z; k++) {
                temp_new[i][j][k] = temp[i][j][k];				
            }
        }
    }

    printf("\n\n ======= Starting Thermal conduction ========\n");       

    //=================================  main cycle start
    for (t=0; t < time_steps; t++)
    {

        for (i=0; i<grid_x; i++)
        {
            for (j=0; j<grid_y; j++)
            {
                for (k=0; k<grid_z; k++)
                {
                    temp_new[i][j][k] = temp_new[i][j][k] + dt *
                                       ((temp[i][(grid_y+(j-1)) % grid_y][k] - 2*temp[i][j][k] + temp[i][(grid_y+(j+1)) % grid_y][k]) / (dy*dy) +
                                        (temp[i][j][(grid_z+(k-1)) % grid_z] - 2*temp[i][j][k] + temp[i][j][(grid_z+(k+1)) % grid_z]) / (dz*dz) +
                                        (temp[(grid_x+(i-1)) % grid_x][j][k] - 2*temp[i][j][k] + temp[(grid_x+(i+1)) % grid_x][j][k]) / (dx*dx) );

                }
            }
        }

        for (i=0;i<grid_x;i++) {
            for (j=0;j<grid_y;j++) {
                for (k=0;k<grid_z;k++) {
                    temp[i][j][k] = temp_new[i][j][k];
                }
            }
        }

        printf("%d step is made... \n",t);
        //****** writing current array to file
       // if (t % intervals == 0) {      
		   print_to_file(t, temp);		       
       // };

    }
    //================================= main cycle end
    printf("Calculations comleted.\n");    

}

void print_to_file(long int n, double ***arr) {

	int kk=1, i, j, k;
	FILE *fp;       
	char buf[20];

	  sprintf(buf, "data_%d.xyz", n/1);

	  fp = fopen(buf, "w"); 
	  if (fp == NULL) {
		 printf("Error opening file!\n");
		 exit(1);
	  }

	  fprintf(fp,"%d\n", N_all);
      fprintf(fp,"ITEM: ATOMS id type xs ys zs\n");


	  for ( i = 0; i < grid_x; i++) {          
		  for ( j = 0; j < grid_y; j++) {  
			  for (k = 0; k < grid_z; k++) {                
				  fprintf(fp, "%d %f %d %d %d\n", kk, arr[i][j][k], i, j, k);									
			      kk++;                
			  }
		  }
      }	 
	  fclose(fp);
}
