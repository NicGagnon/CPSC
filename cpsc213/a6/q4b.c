#include "stdio.h"
#include "stdlib.h"

int x[8] = {1,2,3,-1,-2,0,184,340057058};
int y[8] = {0,0,0,0,0,0,0,0};
int bar();

int bar(int a) {
    int tmp = 0;
    while(a != 0) {
        if ((a & 0x80000000) != 0)
            tmp++;
        a = a*2;
    }
    return tmp;
}

int main (int argc, char* argv[]) {

    int n = sizeof(x)/sizeof(x[0]);
    for (int i = 7; i >= 0; i--) {
        y[i] = bar(x[i]);
    }
    for (int i = 0; i < n; i++) {
        printf("%d\n", x[i]);
    }
    for (int i = 0; i < n; i++) {
        printf("%d\n", y[i]);
    }
}