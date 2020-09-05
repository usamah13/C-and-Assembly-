.pos 0x100
                 ld   $a, r0             #r0 = address of a
                 ld   $b, r1             #r1 = address of b
                 ld   $0x0, r2          #r2 = 0
                 ld   0x0(r1), r3        # r3 = b
                 inc   r3         #r3 = r3 + 1
                 inca  r3      #r3= r3+1
                 shr $0x1, r3     #r3 = r3/2
                 ld   0x0(r1), r4        #r4 = b
                 and r4, r3       #r3 = r3&r4
                 shl $0x2, r3     #r3 << 2
                 st r3, 0x0(r0)   #r0 = r3
                 halt                     # halt
.pos 0x1000
a:               .long 0x0         #a
.pos 0x2000
b:           .long 0x0       #b