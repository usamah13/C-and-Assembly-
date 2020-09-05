//
// This is the solution to CPSC 213 Assignment 5.
// Do not distribute this code or any portion of it to anyone in any way.
// Do not remove this comment.
//

#include <stdlib.h>

#include "mymalloc.h"

/* This metadata structure is stored in the space before each allocation. */
struct metadata {
    int size;
    struct metadata *next;
};

// Base address of the allocated heap.
static char *heap;
// Size of the complete heap.
static int heapsize;
// Next unallocated location in the heap.
static int top;
// Head of the free list
static struct metadata *free_head;

/* Initialize your memory manager to manage the given heap. */
void mymalloc_init(char *_heap, int _heapsize) {
  heap = _heap;
  heapsize = _heapsize;
  top = 0;
  free_head = NULL;
}

/* Allocate a block of memory of the given size, or NULL if unable. 

Returns: a pointer aligned to 8 bytes, or NULL if allocation failed. */
void *mymalloc(int size) {
  /* Round `size` up to a multiple of 8 bytes */
  if(size == 0)
    size = 1;
  size = (size + 7) / 8 * 8;

  /* Add enough bytes to store the metadata */
  size += sizeof(struct metadata);

  /* This implements the first-fit strategy */
  struct metadata *prev = NULL;
  for(struct metadata *ptr = free_head; ptr; ptr = ptr->next) {
    if(size <= ptr->size) {
      /* Big enough - unlink and allocate it */
      if(prev == NULL) {
        free_head = ptr->next;
      } else {
        prev->next = ptr->next;
      }
      /* Remember to shift the pointer over */
      return (void *)ptr + sizeof(struct metadata);
    }
    prev = ptr;
  }

  if(size < 0 || size > heapsize || heapsize - size < top) {
    /* There is not enough room in the heap - fail */
    return NULL;
  }
  /* Allocate the memory from `top` to `top+size` and return an offset pointer */
  struct metadata *res = (struct metadata *)&heap[top];
  top += size;
  res->size = size;
  res->next = NULL;
  return (void *)res + sizeof(struct metadata);
}

/* Free the given block of memory. */
void myfree(void *ptr) {
  /* Shift pointer back to access metadata */
  struct metadata *md = ptr - sizeof(struct metadata);
  /* Link this chunk into our free list */
  md->next = free_head;
  free_head = md;
}
