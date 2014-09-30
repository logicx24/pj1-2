.text

# Decodes a quadtree to the original matrix
#
# Arguments:
#     quadtree (qNode*)
#     matrix (void*)
#     matrix_width (int)
#
# Recall that quadtree representation uses the following format:
#     struct qNode {
#         int leaf;
#         int size;
#         int x;
#         int y;
#         int gray_value;
#         qNode *child_NW, *child_NE, *child_SE, *child_SW;
#     }
#
# 0($a0) = leaf
# 4($a0) = size
# 8($a0) = x
# 12($a0) = y
# 16($a0) = gray_value

quad2matrix:
    lw $t0, 0($a0)              # get leaf word
    addiu $t1, $zero, 1         # load a compare value into $t1
    beq $t0, $t1, TRUE          # check if leaf
    j FALSE
    TRUE:
        lw $t0, 8($a0)          # load x
        lw $t1, 12($a0)         # load y
        lw $t2, 4($a0)          # load size
        lw $t3, 16($a0)         # load gray_value
        addiu $t4, $t0, 0       # int i = x
        addu $t6, $t0, $t2      # max x = x + size
        addu $t7, $t1, $t2      # max y = y + size
        XLOOP:
            addiu $t5, $t1, 0   # int j = y
            YLOOP:
                mul $t8, $t5, $a2
                addu $t8, $t8, $t4
                addu $t8, $a1, $t8  # matrix index
                sb $t3, 0($t8)      # store gray_value in matrix
                addiu $t5, $t5, 1
                blt $t5, $t7, YLOOP
            addiu $t4, $t4, 1
            blt $t4, $t6, XLOOP
        j DONE
    FALSE:
        addiu $sp, $sp, -8
        sw $a0, 0($sp)
        sw $ra, 4($sp)
        lw $a0, 20($a0)
        jal quad2matrix
        lw $ra, 4($sp)
        lw $a0, 0($sp)
        addiu $sp, $sp, 8
        
        addiu $sp, $sp, -8
        sw $a0, 0($sp)
        sw $ra, 4($sp)
        lw $a0, 24($a0)
        jal quad2matrix
        lw $ra, 4($sp)
        lw $a0, 0($sp)
        addiu $sp, $sp, 8
        
        addiu $sp, $sp, -8
        sw $a0, 0($sp)
        sw $ra, 4($sp)
        lw $a0, 28($a0)
        jal quad2matrix
        lw $ra, 4($sp)
        lw $a0, 0($sp)
        addiu $sp, $sp, 8
        
        addiu $sp, $sp, -8
        sw $a0, 0($sp)
        sw $ra, 4($sp)
        lw $a0, 32($a0)
        jal quad2matrix
        lw $ra, 4($sp)
        lw $a0, 0($sp)
        addiu $sp, $sp, 8
    DONE:
    jr $ra
