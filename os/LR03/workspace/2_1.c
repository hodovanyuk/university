#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

char *workfile = "junk";

main(){
	int filedes;

	if( (filedes = open( workfile, O_RDWR )) == -1 ){
		printf(" There is no file ");
		exit(1);
	}
	exit(0);
}