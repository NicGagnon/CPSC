.pos 0x100
                 ld   $a, r0              # r0 = address of a
                 ld   (r0), r1            # r1 = value of a
                 ld   $b, r2              # r2 = address of b
                 ld   (r2), r3            # r3 = value of b
                 ld   $c, r4              # r4 = address of c
                 ld   (r4), r5            # r5 = value of c
                 mov  r3, r5              # r5 = r3
                 inc  r3                  # b += 1
                 shr  $1, r5              # r5 / 2
                 add  r5, r3              # r3 += r5
                 shl  $1, r5              # r5 * 2
                 and  r5, r3              # r3 = r3 & r5
                 shl  $2, r3              # r3 << 2
                 mov  r3, r1              # r1 = r3
                 st   r1, (r0)            # m(r0) = r1
                 halt                     # halt

.pos 0x1000
a:               .long 0x0                # a = 0
b:               .long 0xe                # b = 4
c:               .long 0x0                # c = 0

