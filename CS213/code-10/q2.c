#include <stdlib.h>
#include <stdio.h>
#include "uthread.h"
#include "uthread_mutex_cond.h"

uthread_mutex_t count_lock;
const int N = 100000;
int cnt = 0;

uthread_t t0, t1, t2;

void countUp() {
  for (int i=0; i<N; i++){
    uthread_mutex_lock(count_lock);
    cnt += 1;
    uthread_mutex_unlock(count_lock);
  }
}

void countDown() {
  for (int i=0; i<N; i++){
    uthread_mutex_lock(count_lock);
    cnt -= 1;
    uthread_mutex_unlock(count_lock);
  }
}

void* count(void* v) {
  countUp();
  countDown();
  return NULL;
}

int main(int arg, char** arv) {
  count_lock = uthread_mutex_create();
  uthread_init(4);
  t0 = uthread_create(count, NULL);
  t1 = uthread_create(count, NULL);
  t2 = uthread_create(count, NULL);
  uthread_join (t0, NULL);
  uthread_join (t1, NULL);
  uthread_join (t2, NULL);
  printf("cnt = %d %s\n", cnt, cnt==0? "": "XXX");
  uthread_mutex_destroy(count_lock);
}