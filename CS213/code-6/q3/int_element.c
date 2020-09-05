#include "int_element.h"
#include <stdlib.h>
#include <stdio.h>

/* TODO: Implement all public int_element functions, including element interface functions.

You may add your own private functions here too. */

struct int_element_class {
  void (*print)(struct element *);
  int (*compare)(struct element *, struct element *);
};

struct int_element{
    struct int_element_class *class;
    int value;
};

void int_element_print(struct element *thisv) {
  struct int_element *this = (struct int_element*) thisv;
  printf("%d", this->value);
}

int int_element_compare(struct element *thisv,struct element *thisc) {
  struct int_element *this = (struct int_element*) thisv;
  struct int_element *this2 = (struct int_element*) thisc;
  int a = this->value;
  int b = this->value;
  if (a < b){
      return -1;
  }
  if (a == b){
      return 0;
  }
  else {
      return 1;
  }
}

struct int_element_class int_element_class = {int_element_print, int_element_compare};

struct int_element *int_element_new(int value) {
    struct int_element *obj = rc_malloc(sizeof(struct int_element));
    obj->class = &int_element_class;
    obj->value = value;
    return obj;
};

// struct A *new_A(int i) {
//   struct A *obj = malloc(sizeof(struct A));
//   obj->class = &A_class;
//   obj->i     = i;
//   return obj;
// }

