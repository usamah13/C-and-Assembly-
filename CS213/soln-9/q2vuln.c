//
// This is the solution to CPSC 213 Assignment 7.
// Do not share this code or any portion of it with anyone in any way.
// Do not remove this comment.
//

#include <stdlib.h>
#include <unistd.h>

/* Guessed structure for str1, str2, str3 */
struct string {
  int length;
  char *data;
};

struct string str1 = { 30, "Welcome! Please enter a name:\n" };
struct string str2 = { 11, "Good luck, " };
struct string str3 = { 43, "The secret phrase is \"squeamish ossifrage\"\n" };

void print(struct string *str) {
  write(1, str->data, str->length);
}

int main() {
  char buf[128];
  print(&str1);
  int r4 = read(0, buf, 256);
  print(&str2);
  write(1, buf, r4);
}

void proof() {
  print(&str3);
  exit(0); /* halt */
}
