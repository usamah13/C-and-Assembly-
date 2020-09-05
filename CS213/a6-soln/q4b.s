# This is the solution to CSCP 213 Assignment 7.
# Do not distributed this code or any portion of it to anyone in any way.
# Do not remove this comment.

.pos 0x100
start:
    ld $sb, r5                 # initialise stack pointer...
    inca    r5                 # ...to stack bottom
    gpc $6, r6                 # set return address
    j main                     # call main()
    halt

f:                             # int f (int i)
    deca r5                    # allocate stack frame
    ld $0, r0                  # r0 = temp_j = 0
    ld 4(r5), r1               # r1 = temp_i = i
    ld $0x80000000, r2         # r2 = 0x80000000
f_loop:
    beq r1, f_end              # if(temp_i == 0) goto f_end
    mov r1, r3                 # r3 = temp_i
    and r2, r3                 # r3 = temp_i & 0x80000000
    beq r3, f_if1              # if not (temp_i & 0x80000000) goto f_if1
    inc r0                     # temp_j++ if temp_i & 0x80000000
f_if1:
    shl $1, r1                 # temp_i = temp_i << 1
    br f_loop                  # goto f_loop
f_end:
    inca r5                    # deallocate stack frame
    j(r6)                      # return temp_j (in r0)

main:
    deca r5                    # allocate stack frame
    deca r5                    # allocate stack frame
    st r6, 4(r5)               # save return address
    ld $8, r4                  # r4 = temp_i = 8
main_loop:
    beq r4, main_end           # if (temp_i == 0) goto main_end
    dec r4                     # temp_i--
    ld $x, r0                  # r0 = &x
    ld (r0,r4,4), r0           # r0 = x[temp_i]
    deca r5                    # allocate one int on the stack for parameter
    st r0, (r5)                # push parameter x[i]
    gpc $6, r6                 # set return address
    j f                        # call f(x[temp_i])
    inca r5                    # deallocate stack space for parameter
    ld $y, r1                  # r1 = &y
    st r0, (r1,r4,4)           # y[temp_i] = f(x[temp_i])
    br main_loop               # goto main_loop
main_end:
    ld 4(r5), r6               # restore return address
    inca r5                    # deallocate stack frame
    inca r5                    # deallocate stack frame
    j (r6)                     # return

.pos 0x2000
x:                             # int x[8] = { 1, 2, 3, -1, -2, 0, 184, 340057058 }
    .long 1                    # x[0]
    .long 2                    # x[1]
    .long 3                    # x[2]
    .long 0xffffffff           # x[3]
    .long 0xfffffffe           # x[4]
    .long 0                    # x[5]
    .long 184                  # x[6]
    .long 340057058            # x[7]

y:                             # int y[8];
    .long 0                    # y[0]
    .long 0                    # y[1]
    .long 0                    # y[2]
    .long 0                    # y[3]
    .long 0                    # y[4]
    .long 0                    # y[5]
    .long 0                    # y[6]
    .long 0                    # y[7]

.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0

