.pos 0x100

    ld $i, r0               #r0 address of i
    ld $a, r1               #r1 address of a
    ld $3, r2               #r2=3
    ld (r1,r2,4), r2        #r2= a[3]
    st r2, 0(r0)            #i = a[3]
    ld 0(r0), r2            #r2 = i
    ld (r1,r2,4), r2        #r2= a[i]
    st r2, 0(r0)            #i = a[i]
    
    
    ld $j, r0               #r0 = address of j
    ld $p, r2               # r2 = addresss of p
    st r0, 0(r2)            # p = &j;
    ld 0(r2), r3            # r3 = p the address it self
    ld $4, r4               #r4=4
    st r4, 0(r3)             # *p = 4;

    #p  = &a[a[2]];
    ld 8(r1), r4      #r4 =  a[2]
    shl $2, r4         # r4 = offset
    add r4, r1          #r1 = address of a[a[2]}
    st r1, 0(r2)         #p  = &a[a[2]]

    ld $a, r1               #r1 address of a

    #*p = *p + a[4]
    

    ld 0(r2), r6           # r3 = p the address it self
    ld 0(r6), r3            # r3 = *p 
    ld $4, r4               #r4=4
    ld (r1,r4,4), r5        #r5 = a[4]
    add r5, r3              # *p = *p + a[4]
    st r3, 0(r6)            # writing to memory *p = *p + a[4]

    halt

.pos 0x200
# Data area

i:  .long 3             # a
j:  .long 3             # b
p:  .long 0             #p*
a:  .long 1             # a[0]
    .long 2             # a[1]
    .long 3             # a[2]
    .long 4             # a[3]
    .long 5             # a[4]
    .long 6             # a[5]
    .long 7             # a[6]
    .long 8             # a[7]
    .long 9             # a[8]
    .long 10             # a[9]

