
// Программа runls2 - использует вызов execv для запуска ls

#include <unistd.h>

main() {

   char * const av[] = { "ls","-l",(char *)0 };

   execv( "/bin/ls",av );

   // Если мы оказались здесь, то произошла ошибка
   perror( "execv failed" );
   exit( 1 );
}
