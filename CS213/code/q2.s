.pos 0x100
                 ld $tos, r0      # r0 = address of tos
                 ld $tmp, r1      # r1 = address of tmp
                 ld $0x0, r2      # r2 = 0
                 st r2, 0(r1)     # tmp = 0
                 st r2, 0(r0)     # tos =0
                 ld 0(r0), r2     # r2 = tos
                 ld $a, r3        # r3 = address of a
                 ld $s, r4        # r4 = adress of s
                 ld (r3,r2,4), r5        #r5= a[tos]=a[0]
                 st r5, (r4, r2,4)       #s[tos]=a[0]
                 inc r2                  #r2=1
                 ld (r3,r2,4), r5        #r5= a[tos]=a[1]
                 st r2, 0(r0)     # tos =1
                 ld 0(r0), r2     # r2 = tos
                 st r5, (r4, r2,4)       #s[tos]=a[1]
                 inc r2                  #r2=2
                 ld (r3,r2,4), r5        #r5= a[tos]=a[2]
                 st r2, 0(r0)     # tos =2
                 ld 0(r0), r2     # r2 = tos
                 st r5, (r4, r2,4)       #s[tos]=a[2]
                 inc r2                  #r2=3
                 st r2, 0(r0)     # tos =3
                 ld 0(r0), r2     # r2 = tos
                 dec r2                  #r2=2
                 st r2, 0(r0)     # tos =2
                 ld 0(r0), r2     # r2 = tos
                 ld (r4, r2,4), r5      #r5=s[tos]
                 st r5, 0(r1)     # tmp = s[tos]
                 dec r2                  #r2=1
                 st r2, 0(r0)     # tos =1
                 ld 0(r0), r2     # r2 = tos
                 ld (r4, r2,4), r5      #r5=s[tos]
                 ld 0(r1), r6          #r6 = tmp
                 add r5, r6            # tmp = tmp + s[tos]
                 st r6, 0(r1)         #writing it in tmp
                 dec r2                  #r2=0
                 st r2, 0(r0)     # tos =0
                 ld 0(r0), r2     # r2 = tos
                 ld (r4, r2,4), r5      #r5=s[tos]
                 ld 0(r1), r6          #r6 = tmp
                 add r5, r6            # tmp = tmp + s[tos]
                 st r6, 0(r1)         #writing it in tmp

                 
                 halt                     # halt
.pos 0x1000
a:               .long 1       # a[0]
                 .long 3       # a[1]
                 .long 2       # a[2]
s:
                .long 5       # s[0]
                .long 6      # s[1]
                .long 7       # s[2]
                .long 8       # s[3]
                .long 9       # s[4]
.pos 0x2000
tos:            .long 10        # toss
tmp:            .long 10       # tmp
            
