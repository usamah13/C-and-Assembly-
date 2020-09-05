.pos 0x100
                 ld   $i, r0             #r0 = address of i
                 ld   $y, r1             #r1 = address of y
                 ld   $data, r2          #r2 = address of data
                 ld   0x0(r0), r0        #r0 = i
                 ld   (r2,r0,4), r3      #r3 = array[i]
                 inc  r0                 #r0 = i+1
                 ld   (r2,r0,4), r4      #r4 = array[i+1]
                 add  r4, r3             #r3 = r3+r4
                 st   r3, 0x0(r1)        # y = array[i] + array[i+1], y = r3   
                 ld   $x, r0               #r0 = address of x
                 ld   0x0(r1), r2        #r2 = y
                 ld   $0xff, r3          #r3 = 0xff
                 and r3, r2              #r2 = r2 & r3
                 st r2, 0x0(r0)          #x = y & 0xff, x = r2
                 halt                     # halt
.pos 0x1000
data:            .long 0xffffffff         # data[0]
                 .long 0xffffffff         # data[1]
                 .long 0xffffffff         # data[2]
                 .long 0xffffffff         # data[3]
.pos 0x2000
i:               .long 0x0        #i
.pos 0x3000      
x:               .long 0x0        #x
.pos 0x4000      
y:               .long 0x0        #y

