//
// This is the solution to CPSC 213 Assignment 7.
// Do not share this code or any portion of it with anyone in any way.
// Do not remove this comment.
//

/* This file defines the abstract interface for an element. */
#pragma once

/* Forward struct declaration */
struct element;

struct element_class {
  /* Print this element (without any trailing newline) */
  void (*print)(struct element *);
  /* Compare two elements. int_element should always compare LESS than str_element. */
  int (*compare)(struct element *, struct element *);
};

struct element {
  struct element_class *class;
};
