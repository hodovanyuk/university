
// Программа setmyenv.c - установка окружения программы

main() {

   char *argv[2], *envp[3];

   argv[0] = "showmyenv";
   argv[1] = (char *)0;

   envp[0] = "foo=bar";
   envp[1] = "bar=foo";
   envp[2] = (char *)0;

   execve( "./showmyenv",argv,envp);

   perror( "Ошибка вызова execve" );
}
