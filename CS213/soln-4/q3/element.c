//
// This is the solution to CPSC 213 Assignment 5.
// Do not distribute this code or any portion of it to anyone in any way.
// Do not remove this comment.
//

#include <stdlib.h>
#include <string.h>
#include "element.h"
#include "refcount.h"

/* See the header file for the descriptions of each function. */
struct element {
  int num;
  char *value;
};

/** Create a new element, which holds the given number and string.
 *
 * Postcondition: the created element has its own copy of the string.
 */
struct element *element_new(int num, char *value) {
  struct element *e = rc_malloc(sizeof(*e));
  if(e == NULL) {
    /* out of memory? */
    return NULL;
  }
  e->num = num;
  int slen = strlen(value) + 1; // include null terminator
  e->value = rc_malloc(slen);
  memcpy(e->value, value, slen); // copy string including null terminator
  return e;
}

/** Keep a reference to the element. */
void element_keep_ref(struct element *e) {
  rc_keep_ref(e->value);
  rc_keep_ref(e);
}

/** Release a reference on the element. */
void element_free_ref(struct element *e) {
  rc_free_ref(e->value);
  rc_free_ref(e);
}

/** Get the stored number from an element.
 *
 */
int element_get_num(struct element *e) {
  return e->num;
}

/** Get the stored string from an element.
 *
 * Returns: a pointer to the string value, which is reference-counted.
 * Call rc_keep_ref on the returned pointer if you want to keep a reference to it.
 */
char *element_get_value(struct element *e) {
  return e->value;
}
