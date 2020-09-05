## This is the solution to CPSC 213 Assignment 3
## Do not distribute this to anyone in any way.
## Do not remove this comment.

.pos 0x1000
ld  $a, r0            # r0 = &a[0] == a
ld  $3, r1            # r1 = 3
ld  (r0, r1, 4), r1   # r1 = a[3]
ld  (r0, r1, 4), r1   # r1 = a[a[3]]
ld  $i, r2            # r2 = &i
st  r1, (r2)          # i = a[a[3]]
ld  $j, r1            # r1 = &j
ld  $4, r2            # r2 = 4
st  r2, (r1)          # *p = 4 where p == &j
ld  $2, r2            # r2 = 2
ld  (r0, r2, 4), r2   # r2 = a[2]
shl $2, r2            # r2 = a[2] * 4
add r0, r2            # r2 = &a[0] + a[2] * 4 = &a[a[2]]
ld  $p, r3            # r3 = &p
st  r2, (r3)          # p = &a[a[2]]
ld  (r2), r3          # r3 = *p
ld  $4, r4            # r4 = 4
ld  (r0, r4, 4), r4   # r4 = a[4]
add r4, r3            # r3 = *p + a[4]
st  r3, (r2)          # *p = *p + a[4]
halt

.pos 0x2000
i:  .long 0
j:  .long 0
p:  .long 0
a:  .long 1
    .long 2
    .long 3
    .long 4
    .long 5
    .long 6
    .long 7
    .long 8
    .long 9
    .long 10
