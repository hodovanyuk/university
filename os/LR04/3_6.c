#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv){
    char *filename = "3_6_test";
    if(access(filename, R_OK) == 0){
       printf("User have access to read file %s\n",filename); 
    }else{
        fprintf(stderr,"User have no access to read file %s\n",filename);
    }
    
    if(access(filename, W_OK) == 0){
       printf("User have access to write file %s\n",filename); 
    }else{
        fprintf(stderr,"User have no access to write file %s\n",filename);
    }
    
    if(access(filename, X_OK) == 0){
       printf("User have access to execute file %s\n",filename); 
    }else{
        fprintf(stderr,"User have no access to execute file %s\n",filename);
    }
}


