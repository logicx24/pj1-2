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
        addiu $sp $sp -40
        sw $s0 0($sp)
        sw $s1 4($sp)
        sw $s2 8($sp)
        sw $s3 12($sp)
        sw $s4 16($sp)
        sw $s5 20($sp)
        sw $s6 24($sp)
        sw $s7 28($sp)

        # autostereogram
        lw $s0 40($sp)
        # depth_map
        lw $s1 44($sp)
        # width
        lw $s2 48($sp)
        # height
        lw $s3 52($sp)
        # strip_size
        lw $s4 56($sp)

        # YOUR CODE HERE #
		
		
        addiu $s5, $zero, 0 #int i = 0
        addiu $s6, $zero, 0 #int j = 0

        OUTERLOOP:
                INNERLOOP:
                        blt $s5, $s4, TRUE
                        j FALSE
                        TRUE:
                        		move $s7, $ra
                                jal lfsr_random
                                move $ra, $s7
                                move $t4, $v0
                                mul $t2, $s6, $s2 #j*width
                                add $t2, $t2, $s5 # add i to j * width
                                addu $t3, $t2, $s0 #calculated array index of autosterogram
                                and $t4, $t4, 0xFF
                                sb $t4, 0($t3)
                        		j CONDITION
                        FALSE:
                                mul $t2, $s6, $s2 #j*width
                                add $t2, $t2, $s5
                                addu $t3, $t2, $s0 #calculated array index of autosterogram  
                                addu $t4, $t2, $s1 #calculated array index of depth_map  
                                lb $t5, 0($t4)
                                add $t5, $t5, $s5
                                sub $t5, $t5, $s4

                                mul $t2, $s6, $s2 #j*width
                                add $t2, $t2, $t5
                                addu $s5, $t2, $s0 #calculated array index of autosterogram
                                lb $s6, 0($s5)

                                sb $s6, 0($t3)
                        CONDITION:
                                addi $s6, $s6, 1
                                blt $s6, $s3, INNERLOOP
                        addi $s5, $s5, 1
                        blt $s5, $s2, OUTERLOOP










        lw $s0 0($sp)
        lw $s1 4($sp)
        lw $s2 8($sp)
        lw $s3 12($sp)
        lw $s4 16($sp)
        lw $s5 20($sp)
        lw $s6 24($sp)
        lw $s7 28($sp)
        addiu $sp $sp 40
        jr $ra
