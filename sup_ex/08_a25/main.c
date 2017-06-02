#include <stdio.h>

void printBinary(int x){
    while (x) {
        if (x & 1)
            printf("1");
        else
            printf("0");

        x >>= 1;
    }
    printf("\n");
}

int main() {
    int x,y,z;
    //x = 011
    //y = 010
    //x = 001

    x = 03; y = 02; z = 01;


    printBinary(x);
    printBinary(x | y);
    printBinary(3 | 2 & 0);
//    printBinary(y);
//    printBinary(z);
    printf("%d\n", x | y);
    printf("%d\n", x | y & 0);
//    printf("%d\n", x | y & ~z);
//    printf("%d\n", x ^ y & ~z);
//    printf("%d\n", x & y && z);
    return 0;
}

