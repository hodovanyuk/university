
// Программа myecho - вывод аргументов командной строки

main( int argc,char **argv ) {

   while( --argc > 0 )
      printf( "%s ",*++argv );
   printf( "\n" );
}

char * const argin[] = { "myecho","hello","world",(char *)0 };
execvp( argin[0],argin );
