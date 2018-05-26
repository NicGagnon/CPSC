.pos 0x100
                 ld    $0x3, r0         # r0 = 3
                 ld    $j, r1           # r1 = address of j
                 st    r0, (r1)         # j = 3
                 ld    (r1), r2         # r2 = value of j

                 ld    $i, r3           # r3 = address of i
                 ld    (r3), r4         # r4 = value of i
                 ld    $a, r5           # r5 = address of a
                 ld    (r5, r2, 4), r4  # r4 = a[j]

                 ld    $0x9, r0         # r0 = 9
                 and   r0, r4           # r4 & 9

                 ld    (r5, r4, 4), r4  # r4 = a[i]
                 st    r4, (r3)         # store value of i

                 ld    $p, r6           # r6 = address of p
                 ld    (r6), r6         # r6 = value of p or address of j

                 inc   r2               # j++

                 dec   r2               # p--
                 dec   r2               # p--
                 st    r2, (r1)         # store value of j

                 ld    (r5, r2, 4), r3  # r3 = a[j]
                 shl   $2, r3           # r3 * 4 (offset)
                 add   r5, r3           # r3 = &a + a[j] * 4
                 mov   r3, r6           # p = &a + a[j] * 4

                 ld    $0x4, r0         # r0 = 4
                 ld    (r5, r0, 4), r0  # r0 = a[4]
                 ld    (r5, r2, 4), r3  # r4 = a[j]
                 ld    (r5, r3, 4), r4  # r4 = a[a[j]]
                 add   r0, r4           # r4 += a[4]
                 st    r4, (r5, r3, 4)  # a[a[j]] = r4
                 halt                   # halt

.pos 0x1000
j:               .long 0x0              # i = 0
.pos 0x2000
i:               .long 0x0              # j = 0

.pos 0x3000
p:               .long 0x1000           # p = &j

.pos 0x4000
a:               .long 0x5              # a[0] = 0
                 .long 0x4              # a[1] = 0
                 .long 0x3              # a[2] = 0
                 .long 0x6              # a[3] = 0
                 .long 0x7              # a[4] = 0
                 .long 0x8              # a[5] = 0
                 .long 0x3              # a[6] = 0
                 .long 0x4              # a[7] = 0
                 .long 0x5              # a[8] = 0
                 .long 0x1              # a[9] = 0