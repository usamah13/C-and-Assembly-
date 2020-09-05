//
// This is the solution to CPSC 213 Assignment 5.
// Do not distribute this code or any portion of it to anyone in any way.
// Do not remove this comment.
//

#include <stdlib.h>

#include "mymalloc.h"

/* This file contains a slightly optimized version of mymalloc which stores
   the next pointer directly inside the allocated area, which saves 8 bytes
   per allocation.
   Real malloc implementations do this to save space, but it also means that
   they're more vulnerable to corruption caused by misuse of dangling pointers.
   This file also demonstrates the "best fit" strategy" which makes slightly
   better use of space than the simple "first-fit" strategy.
*/

// set to 0 to try first-fit strategy
#define BESTFIT 1

// Base address of the allocated heap.
static char *heap;
// Size of the complete heap.
static int heapsize;
// Next unallocated location in the heap.
static int top;
// Head of the free list
static void *free_head;

/* Initialize your memory manager to manage the given heap. */
void mymalloc_init(char *_heap, int _heapsize) {
  heap = _heap;
  heapsize = _heapsize;
  top = 0;
  free_head = NULL;
}

/* Helper functions for metadata and pointer manipulation */
static int get_size(void *ptr) {
  return *(int *)(ptr - 8);
}

static void set_size(void *ptr, int size) {
  *(int *)(ptr - 8) = size;
}

static void *get_next(void *ptr) {
  return *(void **)ptr;
}

static void set_next(void *ptr, void *next) {
  *(void **)ptr = next;
}

/* Allocate a block of memory of the given size, or NULL if unable. 

Returns: a pointer aligned to 8 bytes, or NULL if allocation failed. */
void *mymalloc(int size) {
  /* Round `size` up to a multiple of 8 bytes */
  if(size == 0)
    size = 1;
  /* Add 8 bytes to store metadata (size of chunk) */
  size = (size + 7) / 8 * 8 + 8;

#if BESTFIT
  /* This implements the best-fit strategy */
  void *prev = NULL;
  int bestsize = 0;
  void *bestptr = NULL;
  void *bestprev = NULL;
  for(void *ptr = free_head; ptr; ptr = get_next(ptr)) {
    int ptrsize = get_size(ptr);
    if(size <= ptrsize && (bestsize == 0 || ptrsize < bestsize)) {
      /* Big enough and better than other choices */
      bestsize = ptrsize;
      bestptr = ptr;
      bestprev = prev;
    }
    prev = ptr;
  }

  if(bestptr != NULL) {
    /* Found a match - unlink and allocate it */
    if(bestprev == NULL) {
      free_head = get_next(bestptr);
    } else {
      set_next(bestprev, get_next(bestptr));
    }
    return bestptr;
  }
#else
  /* This implements the first-fit strategy */
  void *prev = NULL;
  for(void *ptr = free_head; ptr; ptr = get_next(ptr)) {
    int ptrsize = get_size(ptr);
    if(size <= ptrsize) {
      /* Big enough - unlink and allocate it */
      if(prev == NULL) {
        free_head = get_next(ptr);
      } else {
        set_next(prev, get_next(ptr));
      }
      return ptr;
    }
    prev = ptr;
  }
#endif

  if(size < 0 || size > heapsize || heapsize - size < top) {
    /* There is not enough room in the heap - fail */
    return NULL;
  }
  /* Allocate the memory from `top` to `top+size` and return an offset pointer */
  void *res = &heap[top] + 8;
  top += size;
  set_size(res, size);
  return res;
}

/* Free the given block of memory. */
void myfree(void *ptr) {
  set_next(ptr, free_head);
  free_head = ptr;
}
