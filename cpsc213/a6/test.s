.pos 0x100
                 ld   $a, r0              # r0 = &a
                 ld   0x0(r0), r1         # r1 = a
                 beq  r1, L1              # if a == 0, goto L1

                 ld   $b, r0              # r0 = &b
                 ld   (r0), r1            # r1 = b
                 bgt  r1, L2              # if b > 0, goto L2

                 gpc  $0, r6              # r6 = pc
                 j    4(r6)               # skip next 2 instructions after pc stored at r6
                 inc  r1                  # r1++
                 inc  r1                  # r1++
                 st   r1, (r0)            # m[r0] = r1

                 gpc  $6, r6              # r6 = 6 offset pc
                 j    L3                  # jump to L3
                 inc  r1                  # r1 ++
                 st   r1, (r0)            # r1 ++
                 br   end                 # branch to end

L1:              inc  r1                  # r1 ++
                 st   r1, (r0)            # m[r0] = r1
                 br   end                 # branch to end


L2:              inc  r1                  # r1 ++
                 inc  r1                  # r1 ++
                 st   r1, (r0)            # m[r0] = r1
                 br   end                 # branch to end


L3:              ld   $c, r0              # r0 = &c
                 ld   (r0), r1            # r1 = c
                 inc  r1                  # r1 ++
                 j    (r6)                # jump to pc at r6

end:             halt
.pos 0x1000
a:               .long 0x00000001         # a
.pos 0x2000
b:               .long 0x00000000         # b
.pos 0x3000
c:               .long 0x00000000         # c
