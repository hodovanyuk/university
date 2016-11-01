
// Программа runls3 - выполнить ls как субпроцесс

#include <unistd.h>

main () {

   pid_t pid;

   switch( pid = fork() ) {
   case -1:
      fatal( "Ошибка вызова fork" );
      break;
   case 0:
      // Потомок вызывает exec
      execl( "/bin/ls","ls","-l",(char *)0 );
      fatal( "Ошибка вызова exec" );
      break;
   default:
      // Родительский процесс вызывает wait для приостановки
      // работы до завершения дочернего процесса.
      wait( (int *)0 );
      printf( "Программа ls завершилась\n" );
      exit( 0 );
   }
}

int fatal( char *s ) {
   perror( s );
   exit( 1 );
}
