
// Заголовочный файл для примера
#include "smallsh.h"

// Буферы программы и рабочие указатели
static char inpbuf[ MAXBUF ],
            tokbuf[ 2*MAXBUF ],
           *ptr = inpbuf,
           *tok = tokbuf;

// Вывести приглашение и считать строку
int userin( char *р ) {

   int с, count;

   // Инициализация для следующих процедур
   ptr = inpbuf;
   tok = tokbuf;

   // Вывести приглашение
   printf( "%s",p );

   count = 0;

   while( 1 ) {
      if( ( c = getchar() ) == EOF )
         return( EOF );

      if( count < MAXBUF )
         inpbuf[ count++ ] = c;

      if( с == '\n' && count < MAXBUF ) {
         inpbuf[ count ] = '\0';
         return count;
      }

      // Если строка слишком длинная, начать снова
      if( с == '\n' ) {
         printf( "smallsh: слишком длинная входная строка\n" );
         count = 0;
         printf( "%s ",p );
      }
   }
}

// Получить лексему и поместить ее в буфер tokbuf
int gettok( char **outptr ) {

   int type;

   // Присвоить указателю на строку outptr значение tok
   *outptr = tok;

   // Удалить пробелы из буфера, содержащего лексемы
   while( *ptr ==  ' ' || *ptr == ' \n' )
      ptr++;

   // Установить указатель на первую лексему в буфере
   *tok++ = *ptr;

   // Установить значение переменной type в соответствии
   // с типом лексемы в буфере
   switch( *ptr++ ) {
   case '\n':
      type = EOL;
      break;
   case '&':
      type = AMPERSAND;
      break;
   case ';':
      type = SEMICOLON;
      break;
   default:
      type = ARG;
      // Продолжить чтение обычных символов
      while( inarg( *ptr ) )
         *tok++ = *ptr++;
   }

   *tok++ = '\0';
   return type;
}

static char special[] = { ' ', '\t', '&', ';', '\n', '\0' };

int inarg( char c ) {

   char *wrk;

   for( wrk = special; *wrk; wrk++ ) {
      if( c == *wrk )
         return( 0 );
   }
   return  (1) ;
}

#include "smallsh.h"

int procline( void ) {       // Обработка строки ввода

   char *arg[ MAXARG+1 ];    // Массив указателей для runcommand
   int toktype;              // Тип лексемы в команде
   int narg;                 // Число аргументов
   int type;                 // На переднем плане или в фоне

   narg=0;

   for( ; ; ) {              // Бесконечный цикл
      // Выполнить действия в зависимости от типа лексемы
      switch( toktype = gettok( &arg[ narg ] ) ) {
      case ARG:
         if( narg < MAXARG )
            narg++;
         break;
      case EOL:
      case SEMICOLON:
      case AMPERSAND:
         if( toktype == AMPERSAND )
            type = BACKGROUND;
         else
            type = FOREGROUND;
         if( narg != 0 ) {
            arg[ narg ] = NULL;
            runcommand( arg,type );
         }
         if( toktype == EOL)
            return;

         narg = 0;
         break;
      }
   }
}

#include "smallsh.h"

// Выполнить команду, возможно ожидая ее завершения
int runcommand( char **cline,int where ) {

   pid_t pid;
   int status;

   switch( pid = fork() ) {
   case -1:
      perror( "smallsh" );
      return( -1 );
   case 0:
      execvp( *cline,cline );
      perror( *cline );
      exit( 1 );
   }

   // Код родительского процесса
   // Если это фоновый процесс, вывести pid и выйти
   if( where == BACKGROUND ) {
      printf( "[Идентификатор процесса %d]\n",pid );
      return( 0 );
   }

   // Ожидание завершения процесса с идентификатором pid
   if( waitpid( pid,&status,0 ) == -1 )
      return( -1 );
   else
      return( status );
}

// Программа smallsh - простой командный интерпретатор
#include "smallsh.h"

char *prompt = "Command> ";  // Приглашение ввода командной строки

main () {

   while( userin( prompt ) != EOF )
      procline();
}
