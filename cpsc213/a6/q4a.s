.pos 0x0
                 ld   $sb, r5               # r5 = &sb stack bottom
                 inca r5                    # r5 = &sb + 4
                 gpc  $6, r6                # r6 = pc + 6
                 j    0x300                 # goto function at 0x300
                 halt                     
.pos 0x100
                 .long 0x00001000         
.pos 0x200
                 ld   0x0(r5), r0           # r0 = 3,   1
                 ld   0x4(r5), r1           # r1 = 4,   2
                 ld   $0x100, r2            # r2 = 0x100
                 ld   0x0(r2), r2           # r2 = 0x00001000
                 ld   (r2, r1, 4), r3       # r3 = m[r2[4]]
                 add  r3, r0                # r0 += r3
                 st   r0, (r2, r1, 4)       # m[r2[r1*4]] = r0 - you're adding the top two values from the stack and storing the sum into 0x00001000
                 j    0x0(r6)               # goto address stored in r6
.pos 0x300
                 ld   $0xfffffff4, r0       # r0 = -12
                 add  r0, r5                # r5 += -12 - create 3 memory slots in stack bottom
                 st   r6, 0x8(r5)           # m[r5*8] = r6 - store the return address at the bottom
                 ld   $0x1, r0              # r0 = 1
                 st   r0, 0x0(r5)           # m[r5] = 1 - store 1 at the top of the stack
                 ld   $0x2, r0              # r0 = 2
                 st   r0, 0x4(r5)           # m[r5*4] = 2 - store 2 at the second spot from the top stack
                 ld   $0xfffffff8, r0       # r0 = -8
                 add  r0, r5                # r5 += -8 - add 2 more slots
                 ld   $0x3, r0              # r0 = 3
                 st   r0, 0x0(r5)           # m[r5] = 3 - store 3 at new top
                 ld   $0x4, r0              # r0 =4
                 st   r0, 0x4(r5)           # m[r5] = 4 - store 4 at second from the top
                 # stack looks like : 3 4 1 2 ra
                 gpc  $6, r6                # r6 = pc + 6 - store new return address into r6
                 j    0x200                 # goto 0x200
                 ld   $0x8, r0              # r0 = 8
                 add  r0, r5                # r5 += r0 - move the stack pointer back to (Stack 1 2 ra)
                 ld   0x0(r5), r1           # r1 = 1
                 ld   0x4(r5), r2           # r2 = 2
                 ld   $0xfffffff8, r0       # r0 = -8
                 add  r0, r5                # r5 += -8 - create to new slots
                 st   r1, 0x0(r5)           # m[r5] = r1
                 st   r2, 0x4(r5)           # m[r5*4] = r2 - Stack 1 2 1 2 ra
                 gpc  $6, r6                # r6 = pc + 6
                 j    0x200                 # goto 0x200
                 ld   $0x8, r0              # r0 = 8
                 add  r0, r5                # r5 += 8 - go back to third from top of stack
                 ld   0x8(r5), r6           # r6 = m[r5*8] - load back the ra
                 ld   $0xc, r0              # r0 = 12
                 add  r0, r5                # r5 += 12 - move back the pointer to its OG position
                 j    0x0(r6)               # goto address store at r6
.pos 0x1000
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
