#include <stdlib.h>
#include <stdio.h>
#include "uthread.h"
#include "uthread_mutex_cond.h"

#define NUM_THREADS 4

uthread_mutex_t letter_lock;
uthread_cond_t letter_cond;
int threadnum;
uthread_t threads[NUM_THREADS];

void randomStall() {
  int i, r = random() >> 16;
  while (i++<r);
}

void waitForAllOtherThreads() {
  uthread_mutex_lock(letter_lock);
  while (threadnum > 0) {
    //printf("d\n",threadnum);
    uthread_cond_wait(letter_cond);
  }
  if (threadnum == 0) {
    uthread_cond_broadcast(letter_cond);
  }
  uthread_mutex_unlock(letter_lock);
}

void* p(void* v) {
  randomStall();
  printf("a\n");
  threadnum--;
  waitForAllOtherThreads();
  printf("b\n");
  return NULL;
}

int main(int arg, char** arv) {
  letter_lock = uthread_mutex_create();
  letter_cond = uthread_cond_create(letter_lock);
  threadnum = NUM_THREADS;
  uthread_init(4);
  for (int i=0; i<NUM_THREADS; i++)
    threads[i] = uthread_create(p, NULL);
  for (int i=0; i<NUM_THREADS; i++)
    uthread_join (threads[i], NULL);
  printf("------\n");
  uthread_mutex_destroy(letter_lock);
  uthread_cond_destroy(letter_cond);
}