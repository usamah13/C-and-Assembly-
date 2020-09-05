#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <sys/errno.h>
#include <assert.h>
#include "queue.h"
#include "disk.h"
#include "uthread.h"

queue_t      pending_read_queue;
unsigned int sum = 0;

void interrupt_service_routine () {
  // TODO
  void* t;
  //is_read_pending++;
  //printf("%d\n", is_read_pending);
  queue_dequeue (pending_read_queue, &t, NULL, NULL);
  uthread_unblock(t);
}

void *read_block (void *arg) {
  // TODO schedule read and the update (correctly)
    int* blockno = (int*) arg;
    int result;
    disk_schedule_read (&result, *blockno);
    queue_enqueue(pending_read_queue, uthread_self(), NULL, NULL);
    uthread_block();
    sum+= result;
    //printf("%d\n", sum);
  return NULL;
}

int main (int argc, char** argv) {
  // Command Line Arguments
  //printf("%d\n", sum);
  static char* usage = "usage: tRead num_blocks";
  int num_blocks;
  char *endptr;
  if (argc == 2)
    num_blocks = strtol (argv [1], &endptr, 10);
  if (argc != 2 || *endptr != 0) {
    printf ("argument error - %s \n", usage);
    return EXIT_FAILURE;
  }

  // Initialize
  uthread_init (1);
  disk_start (interrupt_service_routine);
  pending_read_queue = queue_create();
  // Sum Blocks
  // TODO
  uthread_t ts[num_blocks];
  int blocks[num_blocks];
  for (int blockno = 0; blockno < num_blocks; blockno++) {
    blocks[blockno] = blockno;
    ts[blockno] = uthread_create(read_block, &blocks[blockno]);
    //uthread_join(ts[blockno], NULL);
  }
  for (int blockno = 0; blockno < num_blocks; blockno++) {
    uthread_join(ts[blockno], NULL);

  }


  printf("%d\n", sum);
}

