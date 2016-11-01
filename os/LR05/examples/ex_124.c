
// Программа status2 — получение статуса завершения
// дочернего процесса при помощи вызова waitpid

#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>

main() {

   pid_t pid;
   int status, exit_status;

   if( ( pid = fork() ) < 0 )
      fatal( "Ошибка вызова fork " );

   if( pid == 0 ) {          // потомок
      // Вызов библиотечной процедуры sleep
      // для приостановки выполнения на 4 секунды.
      printf( "Потомок %d пауза ...\n",getpid() );
      sleep( 4 );
      exit( 5 );             // Выход с ненулевым значением
   }

   // Если мы оказались здесь, то это родительский процесс
   // Проверить, закончился ли дочерний процесс, и если нет,
   // то сделать секундную паузу, и потом проверить снова
   while( waitpid( pid,&status,WNOHANG ) == 0 ) {
      printf( "Ожидание продолжается...\n" );
      sleep( 1 );
   }

   // Проверка статуса завершения дочернего процесса
   if( WIFEXITED( status ) ) {
      exit_status = WEXITSTATUS( status );
      printf( "Статус завершения %d равен %d\n",pid,exit_status );
   }

   exit( 0 );
}
