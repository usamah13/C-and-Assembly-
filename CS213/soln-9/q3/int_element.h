//
// This is the solution to CPSC 213 Assignment 7.
// Do not share this code or any portion of it with anyone in any way.
// Do not remove this comment.
//

#pragma once

#include "element.h"

/* Forward reference to a int_element. You get to define the structure. */
struct int_element;

/* Static constructor that creates new integer elements. */
struct int_element *int_element_new(int value);
/* Static function that obtains the value held in an int_element. */
int int_element_get_value(struct int_element *);
/* Static function that determines whether this is an int_element. */
int is_int_element(struct element *);
