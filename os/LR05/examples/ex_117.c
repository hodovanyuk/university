
// Программа docommand - запуск команды оболочки, 1 версия

#include <unistd.h>

int docommand( char *command ) {

   pid_t pid;

   if( ( pid = fork() ) < 0 )
      return( -1 );

   if( pid == 0 ) {       // Дочерний процесс
      execl( "/bin/sh","sh","-c",command,(char * ) 0 );
      perror( "execl" );
      exit( 1 );
   }

   // Код родительского процесса
   // Ожидание возврата из дочернего процесса
   wait( (int *)0 );
   return( 0 );
}
