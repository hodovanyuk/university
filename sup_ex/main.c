#include <stdio.h>

int a[3][3] = {{1, 2, 3},
               {4, 5, 6},
               {7, 8, 9}};
int main()
{
    int i;
    for (i = 0; i < 3; i++)
        printf("%d %d\n", *a[i], *(*(a+i)+i));

    return 0;
}