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
                li $s6, 0
                INNERLOOP:
                        blt $s5, $s4, TRUE # if i < S: goto TRUE
                        j FALSE # goto FALSE
                        TRUE:
                        		move $s7, $ra # save $ra
                                jal lfsr_random # get random number in $v0
                                move $ra, $s7 # restore $ra
                                move $t4, $v0 # move random number into $t4
                                mul $t2, $s6, $s2 # $t2 = j*width
                                add $t2, $t2, $s5 # $t2 = $t2 + i / add i to j * width
                                addu $t3, $t2, $s0 # calculated array index of autostereogram
                                and $t4, $t4, 0xFF # remove all but lower 8 bits/1byte of random number
                                sb $t4, 0($t3) # store random number in autostereogram
                        		j DONE
                        FALSE:
                                mul $t2, $s6, $s2 # j * width
                                add $t2, $t2, $s5 # $t2 = $t2 + i
                                addu $t3, $t2, $s0 # calculated array index of autostereogram  
                                addu $t4, $t2, $s1 # calculated array index of depth_map  
                                lb $t5, 0($t4) # store depth(i, j) in $t5
                                add $t5, $t5, $s5 # add i to depth(i, j)
                                sub $t5, $t5, $s4 # subtract S from $t5

                                mul $t2, $s6, $s2 # j * width
                                add $t2, $t2, $t5 # j * width + (i + depth(i ,j) - S)
                                addu $t6, $t2, $s0 # calculated offset array index of autostereogram
                                lb $t7, 0($t6) # load byte from autostereogram
                                sb $t7, 0($t3) # store byte in autostereogram
                        DONE:
                        addi $s6, $s6, 1 # incremement j++
                        blt $s6, $s3, INNERLOOP 
                addi $s5, $s5, 1 # increment i++
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
