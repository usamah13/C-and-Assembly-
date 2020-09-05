//
// This is the solution to CPSC 213 Assignment 7.
// Do not share this code or any portion of it with anyone in any way.
// Do not remove this comment.
//

#include <stdio.h>
#include <stdlib.h>

#include "int_element.h"
#include "str_element.h"
#include "element.h"
#include "refcount.h"

/* If the string is numeric, return an int_element. Otherwise return a str_element. */
struct element *parse_string(char *str) {
  char *endp;
  /* strtol returns a pointer to the first non-numeric character in endp.
     If it gets to the end of the string, that character will be the null terminator. */
  int value = strtol(str, &endp, 10);
  if(str[0] != '\0' && endp[0] == '\0') {
    /* String was non-empty and strtol conversion succeeded - integer */
    return (struct element *)int_element_new(value);
  } else {
    return (struct element *)str_element_new(str);
  }
}

int compare_element(const void *p1, const void *p2) {
  /* qsort passes in pointers to the elements of the array, which are themselves pointers.
     Therefore, here we have to cast the input pointers to "struct element **" and then
     dereference them. */
  struct element *e1 = *(struct element **)p1;
  struct element *e2 = *(struct element **)p2;
  return e1->class->compare(e1, e2);
}

int main(int argc, char **argv) {
  int count = argc - 1;
  struct element **arr = malloc(sizeof(struct element *) * count);
  for(int i=0; i<count; i++) {
    arr[i] = parse_string(argv[i+1]);
  }
  qsort(arr, count, sizeof(struct element *), compare_element);

  /* We use the standard trick of prepending a space to each element to make it look like the array
     is space-separated. This works because we expect a space after the colon. */
  printf("Sorted:");
  for(int i=0; i<count; i++) {
    printf(" ");
    arr[i]->class->print(arr[i]);
  }
  printf("\n");

  for(int i=0; i<count; i++) {
    rc_free_ref(arr[i]);
  }
  free(arr);
}
