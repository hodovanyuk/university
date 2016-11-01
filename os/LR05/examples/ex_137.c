
// Программа showmyenv.c - вывод окружения
main( int argc,char **argv,char **envp ) {

   while( *envp )
      printf( "%s\n",*envp++ );
}
