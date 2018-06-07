.pos 0x100
            ld $0, r0            # r0 = 0 = i
            ld $n, r1            # r1 = &n
            ld (r1), r1          # r1 = n
            ld $0, r7            # r7 = 0


avg:        mov r1, r2           # r2 = n
            not r2               # r2 = -n -1
            inc r2               # r2 = -n
            add r0, r2           # r2 = i - n
            mov r1, r4           # r4 = r1
            beq r2, sort         # if i > n, goto median

            ld $s, r3            # r3 = &s
            mov r0, r4           # r4 = r0
            shl $4, r4           # r4 * 16
            mov r0, r5           # r5 = r0
            shl $3, r5           # r4 * 8
            add r4, r5           # r5 += r4
            mov r3, r4           # r4 = r3
            add r5, r4           # r4 += r5

            ld 4(r4), r2         # sid
            ld 8(r4), r3         # grade[0]
            ld 12(r4), r5        # grade[1]
            add r5, r3           # grade[0] + grade[1]
            ld 16(r4), r5        # grade[2]
            add r5, r3           # grade [0-2]
            ld 20(r4), r5        # grade[3]
            add r5, r3           # grade [0-3]
            shr $2, r3           # r3 = avg (grade[0-3])
            st r3, 24(r4)        # avg = r3
            mov r7, r5           # r5 = r7
            not r5               # -r5 - 1
            inc r5               # -r5
            add r3, r5           # r3 - r5
            ld  $6, r2           # r2 = 6
            bgt r5, stay         # if r5 > 0, then togo stay

swap:       beq r2, stay         # if r2 == 0, then togo stay
            ld (r4), r5          # r5 = m[r4]
            ld 24(r4), r6        # r6 = m[r4 *24]
            st r6, (r4)          # m[r4] = r6
            st r5, 24(r4)        # m[r4 * 24] = r5
            deca r4              # r4 = & -4
            dec r2               # r2 --
            mov r7, r3           # r3 = r7
            br swap              # goto swap

stay:       mov r3, r7           # r7 = r3
            inc r0               # r0 ++
            br avg               # goto avg

restart:    dec r4               # r4 --
            ld $n, r0            # r0 = &n
            ld (r0), r0          # r0 = n
            beq r4, median       # if r4 == 0, goto median
sort:       ld $s, r2            # r2 = &s
sortstart:  dec r0               # r0 --
            beq r0, restart      # if r0 == 0, goto restart
            ld 24(r2), r7        # r7 = current avg
            ld 48(r2), r3        # r3 = old avg
            mov r7, r5           # r5 = r7
            not r5               # -r5 -1
            inc r5               # -r5
            add r3, r5           # r5 += r3
            ld $6, r1            # r1 = 6
            bgt r5, continue     # if r5 > 0, then goto continue

swappy:     beq r1, sortstart    # if r1 ==0, then goto sortstart
            ld 4(r2), r5         # r5 = current student struct detail
            ld 28(r2), r6        # r6 = next student struct detail
            st r6, 4(r2)         # switch current student struct detail
            st r5, 28(r2)        # switch next student struct detail
            inca r2              # r2 += 4
            dec r1               # r1 --
            mov r7, r3           # r3 = r7
            br swappy            # goto swappy

continue:   inca r2              # r2 +=4
            inca r2              # r2 +=4
            inca r2              # r2 +=4
            inca r2              # r2 +=4
            inca r2              # r2 +=4
            inca r2              # r2 +=4
            br sortstart         # goto sortstart

median:     mov r0, r7           # r7 = r0
            shr $1, r7           # r7/2
            mov r7, r4           # r4 = r7
            shl $4, r4           # r4 *16
            mov r7, r5           # r5 = r7
            shl $3, r5           # r5 *3
            add r4, r5           # r5 += r4
            ld  $s, r3           # r3 = &s
            mov r3, r4           # r4 = r3
            add r5, r4           # r4 += r5
            ld 4(r4), r7         # r7 = m[r4 *4]
            br end               # goto end

end:        ld  $m, r0           # r0 = &m
            st  r7, (r0)         # m[m] = r7
            halt




.pos 0x1000
n:          .long 1              # just one student
m:          .long 0              # put the answer here
s:          .long base           # address of the array
base:       .long 2           # student ID
            .long 20             # grade 0
            .long 20             # grade 1
            .long 20             # grade 2
            .long 20            # grade 3
            .long 0              # computed average