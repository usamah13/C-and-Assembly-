//
// This is the solution to CPSC 213 Assignment 7.
// Do not share this code or any portion of it with anyone in any way.
// Do not remove this comment.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "str_element.h"
#include "refcount.h"

struct str_element {
  struct element_class *class;
  char *value;
};

/* Print this element (without any trailing newline) */
static void str_element_print(struct element *e) {
  struct str_element *se = (struct str_element *)e;
  printf("%s", se->value);
}

/* Compare two elements. int_element should always compare LESS than str_element. */
static int str_element_compare(struct element *e1, struct element *e2) {
  if(is_str_element(e2)) {
    char *v1 = ((struct str_element *)e1)->value;
    char *v2 = ((struct str_element *)e2)->value;
    return strcmp(v1, v2);
  } else {
    return 1;
  }
}

static struct element_class str_element_class = { str_element_print, str_element_compare };

static void str_element_finalize(void *p) {
  struct str_element *se = p;
  rc_free_ref(se->value);
}

/* Static constructor that creates new string elements. */
struct str_element *str_element_new(char *value) {
  struct str_element *e = rc_malloc(sizeof(struct str_element), str_element_finalize);
  e->class = &str_element_class;
  int slen = strlen(value) + 1; // include null terminator
  e->value = rc_malloc(slen, NULL);
  memcpy(e->value, value, slen); // copy string including null terminator
  return e;
}

/* Static function that obtains the string from a str_element. The caller should keep_ref it. */
char *str_element_get_value(struct str_element *e) {
  return e->value;
}

/* Static function that determines whether this is an str_element. */
int is_str_element(struct element *e) {
  return e->class == &str_element_class;
}
