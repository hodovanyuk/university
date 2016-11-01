
// Программа proc_file - поведение файлов при ветвлении
// Предположим, что длина файла "data" не менее 20 символов

#include <unistd.h>
#include <fcntl.h>

main() {

   int fd;
   pid_t pid;              // Идентификатор процесса
   char buf[ 10 ];         // Буфер данных для файла

   if( ( fd = open( "data",O_RDONLY ) ) == -1 )
      fatal( "Ошибка вызова open " );

   read( fd,buf,10 );      // Переместить вперед указатель файла

   printpos( "До вызова fork",fd );

   // Создать два процесса
   switch( pid = fork() ) {
   case -1:                // Ошибка
      fatal( "Ошибка вызова fork " );
      break;
   case 0:                 // Потомок
      printpos( "Дочерний процесс до чтения",fd );
      read( fd,buf,10 );
      printpos( "Дочерний процесс после чтения",fd );
      break;
   default:                // Родитель
      wait( (int *)0 );
      printpos( "Родительский процесс после ожидания",fd );
   }
}

// Вывести положение в файле
int printpos( const char *string,int filedes ) {

   off_t pos;

   if( ( pos = lseek( filedes,0,SEEK_CUR ) ) == -1 )
      fatal( "Ошибка вызова lseek" );
   printf( "%s:%ld\n",string,pos );
}
