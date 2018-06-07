#include "stdio.h"
#include "stdlib.h"

int a[10] = {0,0,0,0,0,0,0,0,0,0};
void bar();
void baz();

void bar() {
    int b = 3;
    int c = 4;
    baz(b, c);
    b = 1;
    c = 2;
    baz(b, c);
}

void baz(int i, int j) {
    int tmp = a[j];
    a[j] = tmp + i;
}

int main (int argc, char* argv[]) {
    bar();
    int n = sizeof(a)/sizeof(a[0]);
    for (int i =0; i < n; i++) {
        printf("%d\n", a[i]);
    }
}