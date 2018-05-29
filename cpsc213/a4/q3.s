.pos 0x1000
code:

                ld $s, r0            # r0 = address of s.x[i]
                ld $v0, r1           # r1 = address of v0
                ld (r1), r2          # r2 = value of v0
                ld $i, r3            # r3 = address of i
                ld (r3), r3          # r3 = value of i
                ld (r0, r3, 4), r2   # r2 = s.x[i]
                st r2, (r1)          # store value into memory

                ld $s_y, r0          # r0 = address of s.y[i]
                ld $v1, r1           # r1 = address of v1
                ld (r1), r2          # r2 = value of v1
                ld (r0, r3, 4), r2   # r2 = s.y[i]
                st r2, (r1)          # store value into memory

                ld $s_z, r0          # r0 = address of s.z->x[i]
                ld $v2, r1           # r1 = address of v2
                ld (r1), r2          # r2 = value of v2
                ld (r0, r3, 4), r2   # r2 = s.z->x[i]
                st r2, (r1)          # store value into memory

                ld $s_z_z_y, r0      # r0 = address of s.z->z->y[0]
                ld $v3, r1           # r1 = address of v3
                ld (r1), r2          # r2 = value of v3
                ld (r0, r3, 4), r2   # r2 = s.z->z->y[i]
                st r2, (r1)          # store value into memory
                halt                 # halt

.pos 0x2000
static:
    i:          .long 0
    v0:         .long 0
    v1:         .long 0
    v2:         .long 0
    v3:         .long 0
    s:          .long 1         # s.x[0]
                .long 0         # s.x[1]
                .long 0x3000    # s.y
                .long 0x3008    # s.z
.pos 0x3000
heap:
    s_y:        .long 2         # s.y[0]  start of heap0
                .long 0         # s.y[1]

    s_z:        .long 3         # s.z->x[0]   start of heap1
                .long 0         # s.z->x[1]
                .long 0x3018    # s.z->y
                .long 0x3020    # s.z->z

    s_z_y:      .long 0         # s.z->y[0]
                .long 0         # s.z->y[1]

    s_z_z:      .long 0         # s.z->z->x[0]  start of heap2
                .long 0         # s.z->z->x[1]
                .long 0x3030    # s.z->z->y
                .long 0         # s.z->z->z

    s_z_z_y:    .long 4         # s.z->z->y[0]
                .long 0         # s.z->z->y[1]

