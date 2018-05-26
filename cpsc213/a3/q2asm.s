.pos 0x100
                ld    $0x0, r0        # r0 = 0
                ld    $tmp, r1        # r1 = address of tmp
                st    r0, 0x0(r1)     # tmp = 0
                ld    (r1), r2        # r2 = value of tmp
                ld    $tos, r3        # r3 = address of tos
                st    r0, 0x0(r3)     # tos = 0
                ld    (r3), r4        # r4 = value of tos

                # a[0] = s[tos] + tos;
                ld    $s, r5            # r5 = address of s
                ld    (r5), r5          # r5 = *s to s_ar
                ld    (r5, r4, 4), r6   # r6 = s[tos]
                add   r4, r6            # r6 += tos
                ld    $a, r7            # r7 = address of a
                st    r6, (r7, r0, 4)   # a[0] = r6;

                #a[1] = s[tos] + tos;
                inc   r4                # tos ++
                ld    (r5, r4, 4), r6   # r6 = s[tos]
                add   r4, r6            # r6 += tos
                ld    $0x1, r0          # r0 = 1
                st    r6, (r7, r0, 4)   # a[1] = r6;

                #a[2] = s[tos] + tos;
                inc   r4                # tos ++
                ld    (r5, r4, 4), r6   # r6 = s[tos]
                add   r4, r6            # r6 += tos
                ld    $0x2, r0          # r0 = 1
                st    r6, (r7, r0, 4)   # a[2] = r6;

                inc   r4                # tos ++
                dec   r4                # tos --

                ld    (r7, r4, 4), r2   # r2 = a[tos]
                dec   r4                # tos --
                ld    (r7, r4, 4), r6   # r6 = a[tos]
                add   r6, r2            # r2 += r6
                dec   r4                # tos --
                ld    (r7, r4, 4), r6   # r6 = a[tos]
                add   r6, r2            # r2 += r6
                ld    $0x0, r0          # r0 = 0
                st    r2, (r5, r0, 4)   # store value of s
                st    r2, (r1)          # store value of tmp

                halt                    # halt

.pos 0x1000
tmp:            .long 0                 # tmp
tos:            .long 0                 # tos
s:              .long 0x3000            # s
.pos 0x2000
a:              .long 0                 # a[0]
                .long 0                 # a[1]
                .long 0                 # a[2]
.pos 0x3000
s_ar:           .long 0x5               # s[0]
                .long 0x4               # s[1]
                .long 0x3               # s[2]
                .long 0x2               # s[3]
                .long 0x1               # s[4]



