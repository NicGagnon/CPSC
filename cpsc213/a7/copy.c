int src[2] = {1,2, 0x0000100c};

void copy() {
  int dst[2];
  int i = 0;
  while (src[i] != 0) {
    dst[i] = src[i];
    i++;
  }
  dst[i]=0;
}

int main () {
  copy ();
}