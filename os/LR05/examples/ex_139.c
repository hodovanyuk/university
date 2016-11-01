
// Найти значение переменной окружения PATH

#include <stdlib.h>

main () {

   printf( "PATH=%s\n",getenv( "PATH" ) );
}
