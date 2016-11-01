#include <stdio.h>


int * lsoct(char **argv){
    
    
    static int out[3] ;
    int i;
    int idx = 2;
    for(i=0;i<3;i++){
        out[i]=0;    
    } 
    
    for (i = 0; argv[idx][i] != '\0'; i++){
        if (i < 3){
            if(argv[idx][i] == 'r'){
                out[0] += 4;
            }
            else if(argv[idx][i] == 'w'){
                out[0] += 2;
            }
            else if(argv[idx][i] == 'x'){
                out[0] += 1;
            }
        }
        else if(i < 6){
            if(argv[idx][i] == 'r'){
                out[1] += 4;
            }
            else if(argv[idx][i] == 'w'){
                out[1] += 2;
            }
            else if(argv[idx][i] == 'x'){
                out[1] += 1;
            }
        }
        else {
            if(argv[idx][i] == 'r'){
                out[2] += 4;
            }
            else if(argv[idx][i] == 'w'){
                out[2] += 2;
            }
            else if(argv[idx][i] == 'x'){
                out[2] += 1;
            }
        }
    }

    
    return out;
}

int main(int argc, char **argv)
{
    char *filename = argv[1]; 
    int *out;
    out = lsoct(argv[2]);
    // int *out;
    // int i;
    // out = lsoct(argv);
    // for(i=0;i <= (sizeof( out ) / sizeof( out[0] ));i++){
    //     printf(" %i ",out[i]);    
    // } 
   
}


