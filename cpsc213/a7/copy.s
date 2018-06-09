.pos 0x100
main :           ld   $sb, r5             # r5 = address of last word of stack
                 inca r5                  # r5 = address of first word after stack
                 gpc  $0x6, r6            # ra = pc + 6
                 j    copy                # call copy
                 halt                     
.pos 0x200
copy:            deca r5                  # allocate space for frame
                 st   r6, (r5)            # save return address on stack
                 deca r5
                 deca r5
                 ld   $0, r0              # r0 = 0
                 ld   $src, r1            # r1 = &src
while:           ld   (r1, r0, 4), r2     # r2 = m[r1[i]]
                 beq  r2, zero            # if r2 == 0, then goto zero
                 st   r2, (r5, r0, 4)     # store r2 to stack
                 inc  r0                  # i++
                 br   while               # goto while

zero:            inca r5                  # reset sb to ra
                 inca r5
                 ld   (r5), r6            # load r.a. to r6
                 inca r5                  # reset sb pointer below stack
                 j    (r6)                # goto addr stored at r6


.pos 0x1000
src:             .long 0x1
                 .long 0x1
                 .long 0x100c
                 .long 0xff000000
                 .long 0xffffffff
                 .long 0xff000100
                 .long 0xffffffff
                 .long 0xff000200
                 .long 0xffffffff
                 .long 0xff000300
                 .long 0xffffffff
                 .long 0xff000400
                 .long 0xffffffff
                 .long 0xff000500
                 .long 0xffffffff
                 .long 0xff000600
                 .long 0xffffffff
                 .long 0xff000700
                 .long 0xffffffff
                 .long 0xf000f000

.pos 0x2000
                 .long 0x0                # the runtime stack
                 .long 0x0                
                 .long 0x0                
                 .long 0x0
                 .long 0x0
                 .long 0x0
                 .long 0x0
                 .long 0x0                
sb:              .long 0x0
