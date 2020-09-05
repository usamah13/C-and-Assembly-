#include <stdio.h>
#include <stdlib.h>

int array[4] = {0,0,0,0};

int q2 (int arr0, int arr1, int arr2) {
  static const void* jumpTable[9] = { &&L330, &&L384, &&L334, &&L384, &&L33c, &&L384, &&L354, &&L384, &&L36c };
  
  if (arr0 < 10 || arr0 > 18) goto L6;
  goto *jumpTable [arr0-10];

L330:
  arr2 += arr1;
  goto L7;
L334:
  arr2 = arr1 - arr2;
  goto L7;
L33c:
  if (arr1>arr2){
      arr2 =1;
    goto L7;
  }else {
      arr2 =0;
      goto L7;
  }

L354:
  if (arr2>arr2){
      arr2 =1;
    goto L7;
  }else {
      arr2 =0;
      goto L7;
  }
L36c:
  if (arr1 == arr2){
      arr2 =1;
    goto L7;
  }else {
      arr2 =0;
      goto L7;
  }
L384:
  arr2 = 0;
  goto L7;

L6:
arr2 = 0;
goto L7;

L7:
  return arr2;
}


int main (int argc, char** argv) {
   
   array[3] = q2(array[0], array[1], array[2]);
   printf ("%d\n", array[3]);

}
