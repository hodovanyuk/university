#include <stdio.h>

int * lsoct(char **argv){
    
    
    static int out[3] ;
    int i;
    
    for(i=0;i<3;i++){
        out[i]=0;    
    } 
    
    for (i = 0; argv[1][i] != '\0'; i++){
        if (i < 3){
            if(argv[1][i] == 'r'){
                out[0] += 4;
            }
            else if(argv[1][i] == 'w'){
                out[0] += 2;
            }
            else if(argv[1][i] == 'x'){
                out[0] += 1;
            }
        }
        else if(i < 6){
            if(argv[1][i] == 'r'){
                out[1] += 4;
            }
            else if(argv[1][i] == 'w'){
                out[1] += 2;
            }
            else if(argv[1][i] == 'x'){
                out[1] += 1;
            }
        }
        else {
            if(argv[1][i] == 'r'){
                out[2] += 4;
            }
            else if(argv[1][i] == 'w'){
                out[2] += 2;
            }
            else if(argv[1][i] == 'x'){
                out[2] += 1;
            }
        }
    }

    
    return out;
}

int main(int argc, char **argv)
{
 
    int *out;
    int i;
    out = lsoct(argv);
    for(i=0;i <= (sizeof( out ) / sizeof( out[0] ));i++){
        printf(" %i ",out[i]);    
    } 
   
}


