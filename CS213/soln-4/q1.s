## This is the solution to CPSC 213 Assignment 3
## Do not distribute this to anyone in any way.
## Do not remove this comment.

## Code - TODO: Comment and translated to C in q1()
.pos 0x1000

## C statement 1
S1:
ld    $i, r0            # r0 = &i
ld    (r0), r0          # r0 = i
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a
ld    (r1), r1          # r1 = a->x
ld    (r1, r0, 4), r2   # r2 = a->x[i]
ld    $v0, r3           # r3 = &v0
st    r2, (r3)          # v0 = a->x[i]

## C statement 2
S2:
ld    $i, r0            # r0 = &i
ld    (r0), r0          # r0 = i
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a
inca  r1                # r1 = &a->b.y[0]
ld    (r1, r0, 4), r2   # r2 = a->b.y[i]
ld    $v1, r3           # r3 = &v1
st    r2, (r3)          # v1 = a->b.y[i]

## C statement 3
S3:
ld    $i, r0            # r0 = &i
ld    (r0), r0          # r0 = i
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a
ld    20(r1), r1        # r1 = a->b.a
ld    (r1), r1          # r1 = a->b.a->x
ld    (r1, r0, 4), r2   # r2 = a->b.a->x[i]
ld    $v2, r3           # r3 = &v2
st    r2, (r3)          # v2 = a->b.a->x[i]

## C statement 4
S4:
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a
st    r1, 20(r1)        # a->b.a = a

## C statement 5
S5:
ld    $i, r0            # r0 = &i
ld    (r0), r0          # r0 = i
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a
ld    20(r1), r1        # r1 = a->b.a
inca  r1                # r1 = &a->b.a->b.y[0]
ld    (r1, r0, 4), r2   # r2 = a->b.a->b.y[i]
ld    $v3, r3           # r3 = &v3
st    r2, (r3)          # v3 = a->b.a->b.y[i]


halt


## Globals
.pos 0x2000
i:  .long 1
v0: .long 0
v1: .long 0
v2: .long 0
v3: .long 0
a:  .long a_struct


## Heap (these labels represent dynamic values and are thus not available to code)
.pos 0x3000
a_struct: .long a_x     # a->x
          .long 20      # a->b.y[0]
          .long 21      # a->b.y[1]
          .long 22      # a->b.y[2]
          .long 23      # a->b.y[3]
          .long a_b_a   # a->b.a
a_b_a:    .long a_b_a_x # a->b.a->x
          .long 40       # a->b.a->b.y[0]
          .long 41      # a->b.a->b.y[1]
          .long 42      # a->b.a->b.y[2]
          .long 43      # a->b.a->b.y[3]
          .long 0       # a->b.a->b.a
a_x:      .long 10      # a->x[0]
          .long 11      # a->x[1]
          .long 12      # a->x[2]
          .long 13      # a->x[3]
a_b_a_x:  .long 30      # a->b.a->x[0]
          .long 31      # a->b.a->x[0]
          .long 32      # a->b.a->x[0]
          .long 33      # a->b.a->x[0]
