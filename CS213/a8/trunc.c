#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "list.h"

void print (element_t ev) {
  char* e = (char*) ev;
  printf ("%s\n", e);
}

void printNum (element_t ev) {
  int* e = (int*) ev;
  printf ("%d\n", *e);
}

void isNumber (element_t* rv, element_t av) {
  int **r = (int**) rv;
  char *a = av;
  char *endp;
  *r = malloc(sizeof(int));
  **r  = strtol(a, &endp, 0);
  if(endp[0] != '\0') {
     **r  = -1;
  }
}

void NullString (element_t* rv, element_t av, element_t bv) {
    char **r = (char**) rv;
    char *a = (char *) av;
    int* b = (int*) bv;
    if (*b < 0){
        *r = a;
        //printf ("%s\n", *r);
    }else {
        *r = NULL;
    }
}

int isPositive (element_t av) {
  int *a = (int *)av;
  return (*a >= 0);
}

int isNotNULL(element_t av) {
  char *a = (char *) av;
  return (a != NULL);
}

void Truncate (element_t* rv, element_t av, element_t bv) {
    char **r = (char**) rv;
    char *a = av;
    int* b = bv;
    //printf ("%d\n", *b);
    //printf ("%s\n", a);
    // strncpy(*r, a, sizeof(*r));
    //printf ("%s\n", *r);
    //printf ("hello\n");
    //printf ("%d\n", strlen(*r));
    if (strlen(a) > *b) {
        a[*b] = 0;
    }
    *r = a;
    //printf ("%s\n", *r);
}

void combineString (element_t* rv, element_t av, element_t bv) {
    //printf ("hello\n");
    char **r = (char**) rv;
    char *a = (char*)av;
    char *b = (char*)bv;
    // printf ("%s\n", a);
    // printf ("%s\n", b);
    // printf ("%d\n", strlen(a));
    *r = a;
    *r = realloc(*r, strlen(*r) + 1 + strlen(b) + 1);
    if (strlen(*r) > 0){
        strcat(*r, " ");

    }
    strcat(*r, b);
    // printf ("%s\n", *r);

}

void maximumValue (element_t* rv, element_t av, element_t bv) {
  int *a = av, *b = bv, **r = (int**) rv;
  if ( *a >= *b){
    **r = *a;
  } else {
    **r = *b;
  }
}

int main(int argc, char **argv) {
  int n = argc;
  
  // list of arguments 
  struct list* l0 = list_create();  
  for (int i = 1; i < n; i++){
   list_append (l0, argv[i]);
   }
   
   //list of numbers
   struct list* l1 = list_create();
   list_map1 (isNumber, l1, l0);
   
   //list_foreach (print, l0);
   
   // list of strings
   struct list* l2 = list_create();
  list_map2 (NullString, l2, l0, l1);
  //list_foreach (print, l2);


    // list of positive numbers 
   struct list* l3 = list_create();
   list_filter (isPositive, l3, l1);
//    list_foreach(printNum, l1);
//    list_foreach(printNum, l3);

// list of strings only
   struct list* l4 = list_create();
   list_filter (isNotNULL, l4, l2);
   //list_foreach (print, l4);

    // list of strings truncated
    struct list* l5 = list_create();
    list_map2 (Truncate, l5, l4, l3);
    list_foreach (print, l5);


    char *s = malloc(1);
    *s = 0;
    //printf ("%s\n", s);
    list_foldl (combineString, (element_t*) &s, l5);
    // printf ("fold: %d\n", s);
    printf ("%s\n", s);
    free (s);

    int max = 0, *sp = &max;
    list_foldl (maximumValue, (element_t*) &sp, l3);
    printf ("%d\n", max);

    list_foreach (free, l1);  // free elements allocated by isNUmber in map1
    list_destroy (l0);
    list_destroy (l1);
    list_destroy (l2);
    list_destroy (l3);
    list_destroy (l4);
    list_destroy (l5);


  

}