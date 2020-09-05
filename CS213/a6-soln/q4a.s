# This is the solution to CPSC 213 Assignment 7.
# Do not distributed this code or any portion of it to anyone in any way.
# Do not remove this comment.

.pos 0x0
                 ld   $sb, r5             # initialise stack pointer
                 inca r5                  # ...to bottom of stack
                 gpc  $0x6, r6            # set return address
                 j    bar                 # call main
                 halt                     # end
.pos 0x100
g:               .long 0x1000             # int *g = data;
.pos 0x200
add:             ld   0x0(r5), r0         # r0 = x
                 ld   0x4(r5), r1         # r1 = y
                 ld   $g, r2              # r2 = &g
                 ld   0x0(r2), r2         # r2 = g
                 ld   (r2, r1, 4), r3     # r3 = g[y]
                 add  r3, r0              # r0 = x + g[y]
                 st   r0, (r2, r1, 4)     # v[y] = x + g[y]
                 j    0x0(r6)             # return
.pos 0x300
bar:             ld   $0xfffffff4, r0     # r0 = -12
                 add  r0, r5              # allocate frame on stack
                 st   r6, 0x8(r5)         # save return address
                 ld   $0x1, r0            # r0 = 1
                 st   r0, 0x0(r5)         # local x = 1
                 ld   $0x2, r0            # r0 = 2
                 st   r0, 0x4(r5)         # local y = 2
                 ld   $0xfffffff8, r0     # r0 = -8
                 add  r0, r5              # decrease stack pointer by 8
                 ld   $0x3, r0            # r0 = 3
                 st   r0, 0x0(r5)         # push parameter 3
                 ld   $0x4, r0            # r0 = 4
                 st   r0, 0x4(r5)         # push parameter 4
                 gpc  $0x6, r6            # set return address
                 j    add                 # call add(3,4)
                 ld   $0x8, r0            # r0 = 8
                 add  r0, r5              # discard pushed parameters
                 ld   0x0(r5), r1         # r1 = x
                 ld   0x4(r5), r2         # r2 = y
                 ld   $0xfffffff8, r0     # r0 = -8
                 add  r0, r5              # decrease stack pointer by 8
                 st   r1, 0x0(r5)         # push parameter x
                 st   r2, 0x4(r5)         # push parameter y
                 gpc  $0x6, r6            # set return address
                 j    add                 # call add(x,y)
                 ld   $0x8, r0            # r0 = 8
                 add  r0, r5              # discard pushed parameters
                 ld   0x8(r5), r6         # restore return address
                 ld   $0xc, r0            # r0 = 12
                 add  r0, r5              # deallocate frame on stack
                 j    0x0(r6)             # return
.pos 0x1000
data:            .long 0x0                # data[0]
                 .long 0x0                # data[1]
                 .long 0x0                # data[2]
                 .long 0x0                # data[3]
                 .long 0x0                # data[4]
                 .long 0x0                # data[5]
                 .long 0x0                # data[6]
                 .long 0x0                # data[7]
                 .long 0x0                # data[8]
                 .long 0x0                # data[9]
.pos 0x8000
                 .long 0x0                # These are here so you can see (some of) the stack contents.
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
sb:              .long 0x0                
