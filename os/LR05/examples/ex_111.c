
// Программа runls - использование "execl" для запуска ls

#include <unistd.h>

main () {

   printf( "Запуск программы ls\n" );

   execl( "/bin/ls","ls",(char *)0 );

   // Если execl возвращает значение, то вызов был неудачным
   perror( "Вызов execl не смог запустить программу ls" );
   exit( 1 );
}
