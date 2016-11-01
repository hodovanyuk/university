
// Программа spawn — демонстрация вызова fork

#include <unistd.h>

main() {
   pid_t pid;           // process-id в родительском процессе
   printf( "Пока всего один процесс\n" );
   printf( "Вызов fork...\n" );

   pid = fork();        // Создание нового процесса

   if( pid == 0 )
      printf( "Дочерний процесс\n" );
   else if( pid > 0 )
      printf( "Родительский процесс, pid потомка %d\n",pid );
   else
      printf( "Ошибка вызова fork, потомок не создан\n" );
}
