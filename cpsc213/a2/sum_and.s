.pos 0x100
                 ld   $sum, r0            # r0 = address of sum
                 ld   (r0), r1            # r1 = value of sum
                 ld   $and, r2            # r2 = address of and
                 ld   (r2), r3            # r3 = value of and
                 ld   $b, r4              # r4 = address of b
                 ld   $0x0, r5            # r5 = 0
                 ld   (r4, r5, 4), r1     # r1 = b[0]
                 mov  r1, r6              # r6 = r1
                 ld   $0x1, r5            # r5 = 1
                 ld   (r4, r5, 4), r3     # r6 = b[1]
                 add  r3, r1              # r1 += b[1]
                 st   r1, (r0)            # store new value of sum

                 and  r6, r3              # bitwise AND on i and j
                 st   r3, (r2)            # store reg value of AND back into memory
                 halt                     # halt
.pos 0x1000
sum:             .long 0x0                # sum = 0
.pos 0x2000
and:             .long 0x0                # and = 0

.pos 0x3000
b:               .long 0x9                # b[0] = 9
                 .long 0x7                # b[1] = 7
