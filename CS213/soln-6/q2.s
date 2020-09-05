## This is the solution to CPSC 213 Assignment 3
## Do not distribute this to anyone in any way.
## Do not remove this comment.

.pos 0x1000
ld    $0, r0            # tmp_t = r0 = 0
ld    $0, r1            # tos_t = r1 = 0
ld    $a, r2            # r2 = a
ld    $s, r3            # r3 = s
ld    (r2), r4          # r4 = a[0]
st    r4, (r3, r1, 4)   # s[tos_t] = a[0]
inc   r1                # tos_t++
ld    4(r2), r4         # r4 = a[1]
st    r4, (r3, r1, 4)   # s[tos_t] = a[1]
inc   r1                # tos_t++
ld    8(r2), r4         # r4 = a[2]
st    r4, (r3, r1, 4)   # s[tos_t] = a[2]
inc   r1                # tos_t++
dec   r1                # tos_t--
ld    (r3, r1, 4), r4   # r4 = s[tos_t]
mov   r4, r0            # tmp_t = s[tos_t]
dec   r1                # tos_t--
ld    (r3, r1, 4), r4   # r4 = s[tos_t]
add   r4, r0            # tmp_t = tmp_t + s[tos_t]
dec   r1                # tos_t--
ld    (r3, r1, 4), r4   # r4 = s[tos_t]
add   r4, r0            # tmp_t = tmp_t + s[tos_t]
ld    $tmp, r2          # r2 = &tmp
st    r0, (r2)          # tmp = tmp_t
ld    $tos, r2          # r2 = &tos
st    r1, (r2)          # tos = tos_t
halt

.pos 0x2000
a:    .long 0
      .long 0
      .long 0
s:    .long 0
      .long 0
      .long 0
      .long 0
      .long 0
tos:  .long 0
tmp:  .long 0
