## This is the solution to CPSC 213 Assignment 6
## Do not distribute any part of this file to anyone for any reason
## Do not remove this comment

.pos 0x1000
    ld $0, r0             # r0 = i' = 0
    ld $n, r1             # r1 = &n
    ld (r1), r1           # r1 = n'
    not r1                # r1 = !n'
    inc r1                # r1 = -n'
    ld $a, r3             # r3 = a
    ld $b, r4             # r4 = b
    ld $0, r5             # r5 = c' = 0
L0: mov r1, r2            # r2 = -n'
    add r0, r2            # r2 = i'-n'
    beq r2, L9            # goto L9 if i' == n'
    ld (r3, r0, 4), r6    # r6 = a[i]
    ld (r4, r0, 4), r7    # r7 = b[i]
    not r7                # r7 = !b[i]
    inc r7                # r7 = -b[i]
    add r6, r7            # r7 = a[i]-b[i]
    bgt r7, L1            # goto L1 if a[i] > b[i]
    br L2                 # goto L2
L1: inc r5                # c' += 1 if a[i] > b[i]
L2: inc r0                # i' += 1
    br L0                 # goto L0
L9: ld $i,r1              # r1 = &i
    st r0, (r1)           # i = i'
    ld $c, r1             # r1 = &c
    st r5, (r1)           # c = c'
    halt


.pos 0x2000
i:  .long -1
n:  .long 5
c:  .long 0
a:  .long 10
    .long 20
    .long 30
    .long 40
    .long 50
b:  .long 11
    .long 20
    .long 28
    .long 44
    .long 48

