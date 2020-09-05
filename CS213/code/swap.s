.pos 0x100
                 ld   $t, r0             #r0 = address of t
                 ld   $array, r1         #r1 = address of array
                 ld   $0x0, r2           #r2 = 0
                 ld   (r1,r2,4), r3      #r3 = array[0]  
                 st    r3, 0x0(r0)        #t = array[0]
                 ld   $0x1, r2            #r2 = 1
                 ld   (r1,r2,4), r4       #r4= array[1]
                 st   r4, 0x0(r1)        #array[0] = array[1]
                 ld   0x0(r0), r5         #r5=t
                 st   r5, (r1, r2, 4)   #array[1] = t
                 halt                     # halt
.pos 0x1000
t:               .long 0xffffffff         #t
.pos 0x2000
array:           .long 0xffffffff         # array[0]
                 .long 0xffffffff         # array[1]
                