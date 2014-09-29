#.include "print_helpers.s"
.data

lfsr:
        .align 4
        .half
        0x1

.text

# Implements a 16-bit lfsr
#
# Arguments: None
lfsr_random:

        la $t0 lfsr
        lhu $v0 0($t0) # reg is $v0

        add $t1, $zero, $zero # set for loop variable i to 0
        addi $t9, $zero, 16
        LOOP:
            srl $t2, $v0, 2
            xor $t3, $v0, $t2
            srl $t2, $v0, 3
            xor $t3, $t3, $t2
            srl $t2, $v0, 5
            xor $t3, $t3, $t2
            # end of first line in for loop
            srl $t4, $v0, 1
            sll $t5, $t3, 15
            or $v0, $t4, $t5
            and $v0, $v0, 0x0000FFFF
            addi $t1, $t1, 1
            bne $t1, $t9, LOOP

        la $t0 lfsr
        sh $v0 0($t0)
        jr $ra
