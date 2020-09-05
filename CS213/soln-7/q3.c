//////
// This is part of the solution to UBC, CPSC 213, Assignment 10.
// Do no share this code or any portion of it with anyone in any way.
// Do not remove this comment block.
//////

#include <stdlib.h>
#include <stdio.h>
#include "uthread.h"
#include "uthread_mutex_cond.h"

#define NUM_THREADS 3
uthread_t threads[NUM_THREADS];

uthread_mutex_t mx;
uthread_cond_t  go;
int             arrivals;

void randomStall() {
  int i, r = random() >> 16;
  while (i++<r);
}

void waitForAllOtherThreads() {
  uthread_mutex_lock (mx);
    arrivals += 1;
    if (arrivals < NUM_THREADS)
      uthread_cond_wait (go);
    else 
      uthread_cond_broadcast (go);
  uthread_mutex_unlock (mx);
}

void* p(void* v) {
  randomStall();
  printf("a\n");
  waitForAllOtherThreads();
  printf("b\n");
  return NULL;
}

int main(int arg, char** arv) {
  uthread_init(4);
  mx = uthread_mutex_create();
  go = uthread_cond_create (mx);
  for (int i=0; i<NUM_THREADS; i++)
    threads[i] = uthread_create(p, NULL);
  for (int i=0; i<NUM_THREADS; i++)
    uthread_join (threads[i], NULL);
  printf("------\n");
}