## This is the solution to CPSC 213 Assignment 3
## Do not distribute this to anyone in any way.
## Do not remove this comment.

.pos 0x100
ld    $3, r0            # r0 = temp_a = 3
ld    $a, r1            # r1 = &a
st    r0, (r1)          # a = 3
ld    $p, r2            # r2 = &p
st    r1, (r2)          # p = &a
dec   r0                # r0 = temp_a = 3-1 = 2
st    r0, (r1)          # a = 2 (*p = *p - 1)

ld    $b, r1            # r0 = &b = &b[0]
st    r1, (r2)          # p = &b[0]
mov   r1, r2            # r2 = &b
inca  r2                # r2 = &b[1] (p++)
ld    (r1, r0, 4), r3   # r3 = b[a]
st    r3, (r2, r0, 4)   # p[a] = b[a]
ld    (r1), r1          # r1 = b[0]
inc   r0                # r0 = 2+1 = 3
st    r1, (r2, r0, 4)   # *(p+3) = b[0]
ld    $p, r1            # r1 = &p
st    r2, (r1)          # p = r2
halt

.pos 0x2000
a:    .long 0           # a
p:    .long 0           # p
b:    .long 0           # b[0]
      .long 0           # b[1]
      .long 0           # b[2]
      .long 0           # b[3]
      .long 0           # b[4]
