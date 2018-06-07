.pos 0x100
start:
    ld $sb, r5          # r5 = &sb
    inca    r5          # r5 += 4
    gpc $6, r6          # r6 = pc +6
    j main              # goto main
    halt

f:
    deca r5             # r5 -= 4
    ld $0, r0           # r0 = 0
    ld 4(r5), r1        # r1 = m[r5 * 4]  -
    ld $0x80000000, r2  # r2 = 1000 0000 0000 0000 0000 0000 0000 0000
f_loop:                 #      0b10 1000 1000 1001 1011 0111 1100 010
    beq r1, f_end       # if r1 == 0, then goto f_end
    mov r1, r3          # r3 = r1
    and r2, r3          # r3 = r3 & r2
    beq r3, f_if1       # if r3 == 0, then goto f_if1
    inc r0              # r0++
f_if1:
    shl $1, r1          # r1 =r1 *2
    br f_loop           # goto f_loop
f_end:
    inca r5             # r5 +=4
    j(r6)               # goto address stored at r6

main:
    deca r5             # r5 -=4
    deca r5             # r5 -=4
    st r6, 4(r5)        # m[r5 *4] = r6
    ld $8, r4           # r4 = 8
main_loop:
    beq r4, main_end    # if r4 == 0, then goto main_end
    dec r4              # r4 -= 1
    ld $x, r0           # r0 = &x
    ld (r0,r4,4), r0    # r0 = m[r0[r4]] - 340057058
    deca r5             # r5 -=4
    st r0, (r5)         # m[r5] = r0  Stack : (7, NULL, R.a)
    gpc $6, r6          # r6 = pc + 6
    j f                 # goto f
    inca r5             # r5 += 4
    ld $y, r1           # r1 = &y
    st r0, (r1,r4,4)    # m[r1[r4]] = r0
    br main_loop        # goto main_loop
main_end:
    ld 4(r5), r6        # r6 = m[r5*4]
    inca r5             # r5 += 4
    inca r5             # r5 += 4
    j (r6)              # goto address stored at r6

.pos 0x2000
x:
    .long 1
    .long 2
    .long 3
    .long 0xffffffff
    .long 0xfffffffe
    .long 0
    .long 184
    .long 340057058

y:
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0

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

