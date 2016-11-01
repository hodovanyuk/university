
#include <string.h>
#include <unistd.h>

static int num = 0 ;
static char namebuf[ 20 ];
static char prefix[] = "/tmp/tmp";

char *gentemp( void ) {

   int length;
   pid_t pid;

   pid = getpid();           // Получить идентификатор процесса

   // Стандартные процедуры работы со строками
   strcpy( namebuf,prefix );
   length = strlen( namebuf );

   // Добавить к имени файла идентификатор процесса
   itoa( pid,&namebuf[ length ] );

   strcat( namebuf,"." );
   length = strlen( namebuf );

   do {
      // Добавить суффикс с номером
      itoa( num++,&namebuf[ length ] );
   } while ( access( namebuf,F_OK ) != -1 );

   return( namebuf );
}

// Процедура itoa - преобразует целое число в строку
int itoa ( int i,char *string ) {

   int power,j;

   j = i;

   for( power = 1; j >= 10; j /= 10)
      power *= 10;

   for(  ; power > 0; power /= 10 ) {
      *string++ = '0' + i/power;
      i %= power;
   }

   *string = '\0';
}
