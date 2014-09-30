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
    beq $t0, $t1, TRUE:         # check if leaf
    j FALSE:
    TRUE:
        lw $t2, 8($a0)          # load x
        lw $t3, 12($a0)         # load y
        lw $t6, 4($a0)          # load size
        mul $t3, $t3, $a2       # y * width
        addu $t3, $t3, $t2      # $t3 is starting matrix index
        addu $t4, $t3, $t6      # $t4 is stop index
        LOOP:
            addu $t7, $a1, $t3  # $t7 holds current matrix index
            sb $t7, $t6         # store gray value in matrix current index
            addiu $t3, $t3, 1   # i++
            blt $t3, $t4, LOOP
        j DONE:
    FALSE:
        addiu $sp, $sp, -4
        sw $a0, 0($sp)
        lw $a0, pointer_to_NW
        j quad2matrix
        lw $a0, 0($sp)
        addiu $sp, $sp, 4
        
        addiu $sp, $sp, -4
        sw $a0, 0($sp)
        lw $a0, pointer_to_NE
        j quad2matrix
        lw $a0, 0($sp)
        addiu $sp, $sp, 4
        
        addiu $sp, $sp, -4
        sw $a0, 0($sp)
        lw $a0, pointer_to_SE
        j quad2matrix
        lw $a0, 0($sp)
        addiu $sp, $sp, 4
        
        addiu $sp, $sp, -4
        sw $a0, 0($sp)
        lw $a0, pointer_to_SW
        j quad2matrix
        lw $a0, 0($sp)
        addiu $sp, $sp, 4
    DONE:
    jr $ra
