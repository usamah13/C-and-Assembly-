.pos 0x0
                 ld   $0x1028, r5  # r5 = &0x1028, stack pointer instailization
                 ld   $0xfffffff4, r0  #  r0 = -12 (size of the caller frame)
                 add  r0, r5   # allocate the caller frame
                 ld   $0x200, r0 # r0 = &0x200 of an array
                 ld   0x0(r0), r0 # r0 = array[0]
                 st   r0, 0x0(r5) # put array [0] on the stack
                 ld   $0x204, r0  # r0 = &array[1]
                 ld   0x0(r0), r0  #r0 = array[1] the value
                 st   r0, 0x4(r5)  #put  array[1] to the stack 
                 ld   $0x208, r0    # r0 = &array[2] 
                 ld   0x0(r0), r0   # r0 = &array[2]
                 st   r0, 0x8(r5)  save array[2] to the stack
                 gpc  $6, r6 # go to next pc
                 j    0x300 # go to 0x300, a functiom call
                 ld   $0x20c, r1  # r1 = & array[3]
                 st   r0, 0x0(r1) # 1array[3] = array[2]
                 halt
.pos 0x200   #array
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
.pos 0x300
                 ld   0x0(r5), r0  #r0 = array[0]
                 ld   0x4(r5), r1  #r1 = array[1]
                 ld   0x8(r5), r2  #r2 = array[2]
                 ld   $0xfffffff6, r3  # r3 = -10 
                 add  r3, r0   # r0 = array[0]-10   
                 mov  r0, r3   # r3 = r0
                 not  r3        
                 inc  r3       # r3 = -r0 = 10-array[0]
                 bgt  r3, L6   # if r3 >0 go to L6, or if 10-array[0]>0  or if array[0]<10
                 mov  r0, r3   # r3 = r0
                 ld   $0xfffffff8, r4  # r4 = -8
                 add  r4, r3   # r3 = r3-8 = array[0]-10-8 = array[0]-18
                 bgt  r3, L6   # if array[0]>18 then go to L6
                 ld   $0x400, r3  #r3 = &jump table 
                 ld   (r3, r0, 4), r3   #r3 = load jump table [array[0]-10]
                 j    (r3)          go to jump table [array[0]-10]
.pos 0x330
                 add  r1, r2  #r2 = array[2] + array [1]  (case330)
                 br   L7  #go to L7
                 not  r2 
                 inc  r2 # -r2 = -array[2] 
                 add  r1, r2    r2 = array[1]-array[2] (case330)
                 br   L7    #go to L7
                 not  r2   
                 inc  r2   # -r2 = -array[2] 
                 add  r1, r2    
                 bgt  r2, L0   #if arrray[1]>array[2] go to L0 (case33c)
                 ld   $0x0, r2  # r2 = 0
                 br   L1    # go to l1
L0:              ld   $0x1, r2  #r2= 1
L1:              br   L7    #go to L7
                 not  r1   
                 inc  r1  # -r1 = - array[1]
                 add  r2, r1  #r1 = array[2] - array[1]
                 bgt  r1, L2   #if array[2]> array[1] go to L2 (case354)
                 ld   $0x0, r2 #r2 = 0
                 br   L3 #go to L3
L2:              ld   $0x1, r2  #r2 = 1
L3:              br   L7 #go to L7
                 not  r2  
                 inc  r2 # -r2 = -array[2] 
                 add  r1, r2  #r2 = array[1]-array[2]
                 beq  r2, L4   if array[1] == array[2] go to L4 (case36c)
                 ld   $0x0, r2  #r2 = 0
                 br   L5   # got to L5
L4:              ld   $0x1, r2  # r2 =1 
L5:              br   L7  # go to l7
L6:              ld   $0x0, r2  #r2 = 0 #case384  
                 br   L7   # go to l7
L7:              mov  r2, r0  r0 = r2 
                 j    0x0(r6)  #retrun from function
.pos 0x400 #jump table
                 .long 0x00000330   #case330
                 .long 0x00000384   #case384    
                 .long 0x00000334   #case334
                 .long 0x00000384   #case384    
                 .long 0x0000033c   #case33c
                 .long 0x00000384   #case384    
                 .long 0x00000354   #case354     
                 .long 0x00000384    #case384    
                 .long 0x0000036c   #case36c
.pos 0x1000 # stack
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
