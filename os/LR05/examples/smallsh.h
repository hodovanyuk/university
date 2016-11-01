
// smallsh.h - определения для интерпретатора smallsh

#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

#define EOL          1     // Конец строки
#define ARC          2     // Обычные аргументы
#define AMPERSAND    3     // Символ '&'
#define SEMICOLON    4     // Точка с запятой
#define MAXARG       512   // Макс, число аргументов
#define MAXBUF       512   // Макс, длина строки ввода
#define FOREGROUND   0     // Выполнение на переднем плане
#define BACKGROUND   1     // Фоновое выполнение
