// This is the solution to CPSC 213 Assignment 6.
// Do not distributed this code or any portion of it to anyone in any way.
// Do not remove this comment.

#include <stdio.h>

int data[10];
int *g = data;

void add (int a, int i) {
  g[i] += a;
}

void bar () {
  int x,y;
  x = 1;
  y = 2;
  add (3,4);
  add (x,y);
}

int main() {
  bar();
  for (int i=0; i<10; i++)
    printf ("%d\n", data[i]);
}
