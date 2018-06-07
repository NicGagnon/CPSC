.pos 0x100
                 ld   $i, r0              # r0 = &i
                 ld   (r0), r0            # r0 = i
                 ld   $0, r0              # i = 0
                 ld   $a, r7              # r7 = &a
                 ld   $s, r5              # r5 = &s
                 ld   (r5), r6            # r6 = s
                 ld   $5, r1              # r1 = 5
                 not  r1                  # r1 = -6
                 inc  r1                  # r1 = -5
L0:              mov  r1, r2              # r2 = -5
                 add  r0, r2              # r2 = i - 5
                 beq  r2, end             # if (i > 5), goto end
                 ld   (r7, r0, 4), r3     # r3 = m[a[i]]
                 bgt  r3, L1              # if (a[i] > 0) goto L1
                 inc  r0                  # i++
                 br   L0                  # goto L0
L1:              add  r3, r6              # s += a[i]
                 st   r6, (r5)            # m[r5] = r6
                 inc  r0                  # i ++
                 br   L0                  # goto L0
end:             ld   $i, r7
                 st   r0, (r7)
                 halt
.pos 0x1000
i:               .long 0x0000000a         # i
.pos 0x2000
a:               .long 0x0000000a         # 10
                 .long 0xffffffe2         # -30
                 .long 0xfffffff4         # -12
                 .long 0x00000004         # 4
                 .long 0x00000008         # 8
.pos 0x4000
s:               .long 0x00000000         # s
