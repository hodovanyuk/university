
#include <unistd.h>

main() {

   uid_t uid, euid;
   gid_t gid, egid;

   // Получить истинный идентификатор пользователя
   uid = getuid();

   // Получить действующий идентификатор пользователя
   euid = geteuid();

   // Получить истинный идентификатор группы
   gid = getgid();

   // Получить действующий идентификатор группы
   egid = getegid();

}