//////
// This is part of the solution to UBC, CPSC 213, Assignment 10.
// Do no share this code or any portion of it with anyone in any way.
// Do not remove this comment block.
//////

#include <stdlib.h>
#include <stdio.h>
#include "uthread.h"

uthread_t t0, t1, t2;

void randomStall() {
  int i, r = random() >> 16;
  while (i++<r);
}

void* p0(void* v) {
  randomStall();
  printf("zero\n");
  return NULL;
}

void* p1(void* v) {
  randomStall();
  uthread_join (t0, NULL);  // ADDED
  printf("one\n");
  return NULL;
}

void* p2(void* v) {
  randomStall();
  uthread_join (t1, NULL);  // ADDED
  printf("two\n");
  return NULL;}

int main(int arg, char** arv) {
  uthread_init(4);
  t0 = uthread_create(p0, NULL);
  t1 = uthread_create(p1, NULL);
  t2 = uthread_create(p2, NULL);
  randomStall();
  uthread_join (t2, NULL);  // ADDED
  printf("three\n");
  printf("------\n");
}