#include "stdio.h"
#include "stdlib.h"
int a[4] = {0,0,0,0};

int q2 (int i, int j, int k) {
  void* jumpTable[] = { &&L330, &&L384, &&L334, &&L384, &&L33C, &&L384, &&L354, &&L384, &&L36C};
  if (i < 10 || i > 18) {
      goto L6;
    }
  goto *jumpTable[i-10];

L330:
    k += j;
    goto L7;

L334:
    k = -k + j;
    goto L7;

L33C:
    k = -k + j;
    if (k > 0) {
        k = 1;
        goto L7;
    } else {
        k = 0;
        goto L7;
    }
L354:
    j = -j + k;
    if (j > 0) {
        k = 1;
        goto L7;
    } else {
        k = 0;
        goto L7;
    }

L36C:
    k = -k + j;
    if (k == 0) {
        k = 1;
        goto L7;
    } else {
        k = 0;
        goto L7;
    }
L384:
    k = 0;
    goto L7;
L6:
    k = 0;
    goto L7;
L7:
    return k;
}
int main (int argc, char* argv[]) {
    a[3] = q2(a[0], a[1], a[2]);
}