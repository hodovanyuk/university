
// Программа status - получение статуса завершения потомка

#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>

main () {

   pid_t pid;
   int status, exit_status;

   if( ( pid = fork() ) < 0 )
      fatal( "Ошибка вызова fork " );

   if( pid == 0 ) {          // Потомок
      // Вызвать библиотечную процедуру sleep
      // для временного прекращения работы на 4 секунды.
      sleep( 4 );
      exit( 5 );             // Выход с ненулевым значением
   }

   // Если мы оказались здесь, то это родительский процесс,
   // поэтому ожидать завершения дочернего процесса
   if( ( pid = wait( &status ) ) == -1 ) {
      perror( "Ошибка вызова wait " );
      exit( 2 );
   }

   // Проверка статуса завершения дочернего процесса
   if( WIFEXITED( status ) ) {
      exit_status = WEXITSTATUS( status );
      printf( "Статус завершения %d равен %d\n",pid,exit_status );
   }
   exit( 0 );
}
