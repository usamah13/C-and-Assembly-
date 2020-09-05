/* This header file defines the element structure and functions to operate on it. */
#pragma once

/** Structure forward declaration. Without a full declaration of the structure,
   the structure implementation is "private" to other modules - they must only use the public API. */
struct element;

/** Create a new element, which holds the given number and string.
 *
 * Postcondition: the created element has its own copy of the string.
 */
struct element *element_new(int num, char *value);

/** Keep a reference to the element. */
void element_keep_ref(struct element *e);

/** Release a reference on the element. */
void element_free_ref(struct element *e);

/** Get the stored number from an element.
 *
 */
int element_get_num(struct element *e);

/** Get the stored string from an element.
 *
 * Returns: a pointer to the string value, which is reference-counted.
 * Call rc_keep_ref on the returned pointer if you want to keep a reference to it.
 */
char *element_get_value(struct element *e);
