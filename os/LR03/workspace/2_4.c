#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>


main(){
	int filedes;
    const char *pathname = "twodotthree";
    
    filedes = creat(pathname, 0644);
	if( (filedes = open( pathname, O_RDONLY )) == -1 ){
		printf(" Could not read file %c",*pathname);
		exit(1);
	}
	if( (filedes = open( pathname, O_WRONLY )) == -1 ){
		printf(" Could not write file %c",*pathname);
		exit(1);
	}
	printf(" Everything fine ");
	exit(0);
}