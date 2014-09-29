.text

# Generates an autostereogram inside of buffer
#
# Arguments:
#     autostereogram (unsigned char*)
#     depth_map (unsigned char*)
#     width
#     height
#     strip_size
calc_autostereogram:

        # Allocate 5 spaces for $s0-$s5
        # (add more if necessary)
        addiu $sp $sp -20
        sw $s0 0($sp)
        sw $s1 4($sp)
        sw $s2 8($sp)
        sw $s3 12($sp)
        sw $s4 16($sp)

        # autostereogram
        lw $s0 20($sp)
        # depth_map
        lw $s1 24($sp)
        # width
        lw $s2 28($sp)
        # height
        lw $s3 32($sp)
        # strip_size
        lw $s4 36($sp)

        # YOUR CODE HERE #

        addiu $t0, $zero, 0 #int i = 0
        addiu $t1, $zero, 0 #int j = 0

        OUTERLOOP:
                INNERLOOP:
                        blt $t0, $s4, TRUE
                        j FALSE
                        TRUE:
                                mul $t2, $t1, $s2 #j*width
                                add $t2, $t2, $t0
                                addu $t3, $t2, $s0 #calculated array index of autosterogram
                                addu $t4, $zero, $zero
                                jal lfsr_random
                                move $t4, $v0
                                and $t4, $t4, 0xFF
                                sb $t4, 0($t3)
                        j CONDITION
                        FALSE:
                                mul $t2, $t1, $s2 #j*width
                                add $t2, $t2, $t0
                                addu $t3, $t2, $s0 #calculated array index of autosterogram  
                                addu $t4, $t2, $s1 #calculated array index of depth_map  
                                lw $t5, 0($t4)
                                add $t5, $t5, $t0
                                sub $t5, $t5, $s4

                                mul $t2, $t1, $s2 #j*width
                                add $t2, $t2, $t5
                                addu $t6, $t2, $s0 #calculated array index of autosterogram
                                lw $t7, 0($t6)

                                sb $t7, 0($t3)
                        CONDITION:
                                addi $t1, $t1, 1
                                blt $t1, $s3, INNERLOOP
                                addi $t0, $t0, 1
                                blt $t0, $s2, OUTERLOOP










        lw $s0 0($sp)
        lw $s1 4($sp)
        lw $s2 8($sp)
        lw $s3 12($sp)
        lw $s4 16($sp)
        addiu $sp $sp 20
        jr $ra
