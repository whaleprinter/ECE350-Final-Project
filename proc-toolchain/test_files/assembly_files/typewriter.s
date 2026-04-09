nop
nop
addi $r20, $r0, 13 # Store value of enter key
addi $r22, $r0, 700 # Store the maximum X-limit
addi $xpos, $r0, 0
addi $ypos, $r0, 0

addi $N,  $r0, 60        # height 
addi $NH, $r0, 30       # half height
addi $S,  $r0, 15        # letter spacin
# $r20 will store the enter character value
# $r21 will store the last character address
# $a0 will store the temporary final X-position after a letter
nop
nop
    
# TESTING:
    # A
    addi $t0, $r0, 97
    addi $cp, $r0, 0
    nop
    nop
    nop
    sw $t0, 0($cp)
    nop
    nop
    nop
    # M
    addi $t0, $r0, 109
    addi $cp, $r0, 1
    nop
    nop
    nop
    sw $t0, 0($cp)
    nop
    nop
    nop
    # R
    addi $t0, $r0, 114
    addi $cp, $r0, 2
    nop
    nop
    nop
    sw $t0, 0($cp)
    nop
    nop
    nop
    # I
    addi $t0, $r0, 105
    addi $cp, $r0, 3
    nop
    nop
    nop
    sw $t0, 0($cp)
    nop
    nop
    nop
    # T
    addi $t0, $r0, 116
    addi $cp, $r0, 4
    nop
    nop
    nop
    sw $t0, 0($cp)
    nop
    nop
    nop
    # A
    addi $t0, $r0, 97
    addi $cp, $r0, 5
    nop
    nop
    nop
    sw $t0, 0($cp)
    nop
    nop
    nop
    # # ' '
    # addi $t0, $r0, 32
    # addi $cp, $r0, 6
    # nop
    # nop
    # nop
    # sw $t0, 0($cp)
    # nop
    # nop
    # nop
    # # D
    # addi $t0, $r0, 100
    # addi $cp, $r0, 7
    # nop
    # nop
    # nop
    # sw $t0, 0($cp)
    # nop
    # nop
    # nop
    # # U
    # addi $t0, $r0, 117
    # addi $cp, $r0, 8
    # nop
    # nop
    # nop
    # sw $t0, 0($cp)nop
    # nop
    # nop
    # nop
    # # K
    # addi $t0, $r0, 107
    # addi $cp, $r0, 9
    # nop
    # nop
    # nop
    # sw $t0, 0($cp)
    # nop
    # nop
    # nop
    # # E
    # addi $t0, $r0, 101
    # addi $cp, $r0, 10
    # nop
    # nop
    # nop
    # sw $t0, 0($cp)
    nop
    nop
    nop
    
    j exit_keyboard_loop


keyboard_loop:
    poll $ki
    nop
    nop
    nop
    nop
    nop
    nop
    bne $ki, $r20, exit_keyboard_loop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    sw $ki, 0($cp)
    nop
    nop
    nop
    nop
    nop
    nop
    addi $cp, $cp, 1
    nop
    nop
    nop
    nop
    nop
    nop
    j keyboard_loop

exit_keyboard_loop:

addi $r21, $cp, 0 # Store last character address
addi $cp, $r0, 0 # Zero the pointer

print_loop:     
        nop
        nop
        nop
        lw $let, 0($cp) # Load the next character to print into the temp register
        nop
        nop
        nop
        
        nop
        nop
        nop
        addi $a0, $xpos, 200 # PUT MAX CHARACTER WIDTH HERE
        nop
        nop
        nop
        jal new_line # New line will check if a new line is needed. If so, it will make a new line. Otherwise, it will return here
        nop
        nop
        nop

        j letter_table
        # jr $let # Jump down to the letter in assembly

    # May need to use a bunch of branches. Just rewire bne to be beq
    return_from_letter:

        # May remove this if including it in the 
        pen 0 # Pull the pen up in case
        addi $zpos, $r0, 0 # Store pen state
        nop
        nop
        nop
        nop
        bne $cp, $r21, exit_print_loop # Check if end of string reached and break
        nop
        nop
        nop
        nop
        addi $cp, $cp, 1 # Increment pointer
        # move $r0, $dx, $dy # Perform pen move for character space
    j print_loop
    nop
    nop
    nop
    nop

new_line:
    blt $r22, $a0, continue_new_line

    jr $ra

    continue_new_line:
    
        sub $dx, $r0, $xpos
        nop
        nop
        nop

       
        addi $dy, $r0, -100
        nop
        nop
        nop



        addi $xpos, $r0, 0
        nop
        nop
        nop

        add $ypos, $ypos, $dy
        nop
        nop
        nop
        move $r0, $dx, $dy 

    jr $ra


exit_print_loop:
    nop
    nop
    nop
    nop
    # Force a new line at the end of the string
    jal continue_new_line 
    nop
    nop
    nop

    # Reset Pointer
    addi $cp, $r0, 0 
    nop
    nop
    nop

    # Restart Loop
    j keyboard_loop
    nop
    nop
    nop

letter_table:

    addi $templetcomp, $r0, 97
    nop
    nop
    nop      
    bne  $let, $templetcomp, A
    nop
    nop
    nop

    addi $templetcomp, $r0, 98      
    nop
    nop
    nop
    bne  $let, $templetcomp, B
    nop
    nop
    nop

    addi $templetcomp, $r0, 99 
    nop
    nop
    nop
    bne  $let, $templetcomp, C
    nop
    nop
    nop

    addi $templetcomp, $r0, 100
    nop
    nop
    nop
    bne  $let, $templetcomp, D
    nop
    nop
    nop

    addi $templetcomp, $r0, 101
    nop
    nop
    nop
    bne  $let, $templetcomp, E
    nop
    nop
    nop

    addi $templetcomp, $r0, 102
    nop
    nop
    nop
    bne  $let, $templetcomp, F
    nop
    nop
    nop

    addi $templetcomp, $r0, 103
    nop
    nop
    nop
    bne  $let, $templetcomp, G
    nop
    nop
    nop

    addi $templetcomp, $r0, 104
    nop
    nop
    nop
    bne  $let, $templetcomp, H
    nop
    nop
    nop

    addi $templetcomp, $r0, 105
    nop
    nop
    nop
    bne  $let, $templetcomp, I
    nop
    nop
    nop

    addi $templetcomp, $r0, 106
    nop
    nop
    nop
    bne  $let, $templetcomp, J
    nop
    nop
    nop

    addi $templetcomp, $r0, 107
    nop
    nop
    nop
    bne  $let, $templetcomp, K
    nop
    nop
    nop

    addi $templetcomp, $r0, 108
    nop
    nop
    nop
    bne  $let, $templetcomp, L
    nop
    nop
    nop

    addi $templetcomp, $r0, 109
    nop
    nop
    nop
    bne  $let, $templetcomp, M
    nop
    nop
    nop

    addi $templetcomp, $r0, 110
    nop
    nop
    nop
    bne  $let, $templetcomp, N
    nop
    nop
    nop

    addi $templetcomp, $r0, 111
    nop
    nop
    nop
    bne  $let, $templetcomp, O
    nop
    nop
    nop

    addi $templetcomp, $r0, 112
    nop
    nop
    nop
    bne  $let, $templetcomp, P
    nop
    nop
    nop

    addi $templetcomp, $r0, 113
    nop
    nop
    nop
    bne  $let, $templetcomp, Q
    nop
    nop
    nop

    addi $templetcomp, $r0, 114
    nop
    nop
    nop
    bne  $let, $templetcomp, R
    nop
    nop
    nop

    addi $templetcomp, $r0, 115
    nop
    nop
    nop
    bne  $let, $templetcomp, S
    nop
    nop
    nop

    addi $templetcomp, $r0, 116
    nop
    nop
    nop
    bne  $let, $templetcomp, T
    nop
    nop
    nop

    addi $templetcomp, $r0, 117
    nop
    nop
    nop
    bne  $let, $templetcomp, U
    nop
    nop
    nop

    addi $templetcomp, $r0, 118
    nop
    nop
    nop
    bne  $let, $templetcomp, V
    nop
    nop
    nop

    addi $templetcomp, $r0, 119
    nop
    nop
    nop
    bne  $let, $templetcomp, W
    nop
    nop
    nop

    addi $templetcomp, $r0, 120
    nop
    nop
    nop
    bne  $let, $templetcomp, X
    nop
    nop
    nop

    addi $templetcomp, $r0, 121
    nop
    nop
    nop
    bne  $let, $templetcomp, Y
    nop
    nop
    nop

    addi $templetcomp, $r0, 122
    nop
    nop
    nop
    bne  $let, $templetcomp, Z
    nop
    nop
    nop

    # Numbers
    addi $templetcomp, $r0, 48
    nop
    nop
    nop
    bne  $let, $templetcomp, D0
    nop
    nop
    nop

    addi $templetcomp, $r0, 49
    nop
    nop
    nop
    bne  $let, $templetcomp, D1
    nop
    nop
    nop

    addi $templetcomp, $r0, 50
    nop
    nop
    nop
    bne  $let, $templetcomp, D2
    nop
    nop
    nop

    addi $templetcomp, $r0, 51
    nop
    nop
    nop
    bne  $let, $templetcomp, D3
    nop
    nop
    nop

    addi $templetcomp, $r0, 52
    nop
    nop
    nop
    bne  $let, $templetcomp, D4
    nop
    nop
    nop

    addi $templetcomp, $r0, 53
    nop
    nop
    nop
    bne  $let, $templetcomp, D5
    nop
    nop
    nop

    addi $templetcomp, $r0, 54
    nop
    nop
    nop
    bne  $let, $templetcomp, D6
    nop
    nop
    nop

    addi $templetcomp, $r0, 55
    nop
    nop
    nop
    bne  $let, $templetcomp, D7
    nop
    nop
    nop

    addi $templetcomp, $r0, 56
    nop
    nop
    nop
    bne  $let, $templetcomp, D8
    nop
    nop
    nop

    addi $templetcomp, $r0, 57
    nop
    nop
    nop
    bne  $let, $templetcomp, D9
    nop
    nop
    nop

    addi $templetcomp, $r0, 32      # ' '
    nop
    nop
    nop
    bne  $let, $templetcomp, SPACE
    nop
    nop
    nop

    j return_from_letter

SPACE:
    # Travel 1:
    pen 0 # Pen down
    addi $zpos, $r0, 0 # Update pen state
    addi $dx, $r0, 15
    addi $dy, $r0, 0
    add $xpos, $xpos, $dx # Update global location
    add $ypos, $ypos, $dy 
    move $r0, $dx, $dy # Perform pen move for character 

    j return_from_letter




A:
    # Left vertical up 
    pen 1
    add  $dx, $r0, $r0      
    add  $dy, $r0, $N        
    add  $ypos, $ypos, $N
    move $r0, $dx, $dy    

    # Travel back to baseline 
    pen 0
    add  $dx, $r0, $r0
    sub  $dy, $r0, $N        
    sub  $ypos, $ypos, $N
    move $r0, $dx, $dy       

    add  $dx, $r0, $N       
    add  $dy, $r0, $r0
    add  $xpos, $xpos, $N
    move $r0, $dx, $dy      

    # Right vertical up
    pen 1
    add  $dx, $r0, $r0
    add  $dy, $r0, $N
    add  $ypos, $ypos, $N
    move $r0, $dx, $dy     

    # Travel to left mid 
    pen 0
    add  $dx, $r0, $r0
    sub  $dy, $r0, $NH      
    sub  $ypos, $ypos, $NH
    move $r0, $dx, $dy     

    sub  $dx, $r0, $N       
    add  $dy, $r0, $r0
    sub  $xpos, $xpos, $N
    move $r0, $dx, $dy     

    # Crossbar (left -> right)
    pen 1
    add  $dx, $r0, $N        # to (N, NH)
    add  $dy, $r0, $r0
    add  $xpos, $xpos, $N
    move $r0, $dx, $dy

    # Return to baseline at right leg
    pen 0
    add  $dx, $r0, $r0
    sub  $dy, $r0, $NH      
    sub  $ypos, $ypos, $NH
    move $r0, $dx, $dy      

    # Spacing for next letter
    add  $dx, $r0, $S      
    add  $dy, $r0, $r0
    add  $xpos, $xpos, $S
    move $r0, $dx, $dy      

    j return_from_letter

# B: left vertical + two loops (top and bottom)
B:
    # Left vertical up
    pen 1
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy     
    nop
    nop
    nop

    # Top horizontal to right
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop

    # Down to mid
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy      
    nop
    nop
    nop

    # Back to left mid
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       
    nop
    nop
    nop

    # Bottom half
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop

    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop

    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop

    # Spacing
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy   
    nop
    nop
    nop

    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop

    j return_from_letter

# C: open rectangle on right
C:

    # Left vertical up
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       
    nop
    nop
    nop

    # Top horizontal right
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       
    nop
    nop
    nop

    # Travel to bottom-right
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       
    nop
    nop
    nop
    # Bottom horizontal left
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       
    nop
    nop
    nop

    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
# D: left vertical + right vertical + top/bottom

D:
    # Left vertical up
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy      
    # Top horizontal right
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       
    # Right vertical down
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop
    add  $dx, $r0, $r0     
    nop
    nop
    nop
    sub  $dx, $dx, $N       
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop

# E: full left vertical, top/mid/bottom horizontals
E:
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy     
    nop
    nop
    nop
    # Top horizontal
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Travel to mid-left
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy     
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy      
    nop
    nop
    nop
    # Mid horizontal
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy      
    nop
    nop
    nop

    # Travel to bottom-left
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy       
    nop
    nop
    nop
    # Bottom horizontal
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy   
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop

    j return_from_letter
    nop
    nop
    nop

# F: like E but no bottom bar
F:
    # Left vertical up
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    # Top horizontal
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    # Travel to mid-left
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy      
    # Mid horizontal
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy      
    # Return to baseline left
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy 
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy      
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
# G: like C but with inner mid stroke

G:
    # Left vertical up
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       
    nop
    nop
    nop
    # Top horizontal to right
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy      
    nop
    nop
    nop
    # Down to baseline
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy     
    nop
    nop
    nop
    # Bottom horizontal left
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dx, $dx, $N       
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       
    # Travel to mid-right
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $NH
    nop
    nop
    nop
    add  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy      
    # Small inner horizontal left 
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    sub  $dx, $r0, $NH
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop
    # Return to baseline and spacing
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy   
    nop
    nop
    nop
    add  $dx, $r0, $NH      
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy       
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy   
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
# H: two verticals + mid crossbar
H:
    # Left vertical up
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy      
    nop
    nop
    nop
    # Travel back to baseline
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy   
    # Move to right leg baseline
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       
    nop
    nop
    nop
    # Right vertical up
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy      
    # Travel to mid-right
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy 
    # Mid crossbar
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy 
    # Return to baseline-right
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy 
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy       
    # Spacing
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop

# I: simple vertical line
I:
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy      
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy      
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
# J: vertical + bottom hook

J:
    # Start a bit to the right of where you called J (assumes caller placed xpos)
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy      
    # Back down
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       # baseline
    # Bottom hook left
    nop
    nop
    nop
    sub  $dx, $r0, $NH
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Travel to rightmost baseline and space
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N        # go right across hook + main
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop

# K: left vertical + two small diagonals (approximated with horiz+vert)

K:
    # Left vertical
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Travel back to mid-left
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy       # (0, NH)
    nop
    nop
    nop
    # Upper arm 
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       
    nop
    nop
    nop
    # Travel back to mid-left
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy      
    # Lower arm (mid to bottom-right-ish)
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy       
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
# L: vertical + bottom horizontal
L:
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       # up
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       # down
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       # bottom bar
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop

# M: like H but with extra middle vertical hint
M:
    # Left vertical
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy 
    # Travel to baselinemid
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy 
    nop
    nop
    nop 
    add  $dx, $r0, $NH
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy  
    nop
    nop
    nop
    # Middle vertical
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy 
    # Travel to baseline-right
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       
    nop
    nop
    nop
    add  $dx, $r0, $NH
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy 
    # Right vertical
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy  
    # Back to baseline-right
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy  
    # Spacing
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop

# N: left and right vertical, with mid connection (simplified)
N:
    # Left vertical
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    # Travel to baseline-right
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy     
    nop
    nop
    nop
    # Right vertical
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop

# O: rectangle
O:
    pen 1
    nop
    nop
    nop
    # Left vertical up
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Top horizontal right
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Right vertical down
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Bottom horizontal left
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       # back at baseline-left
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop

# P: like B top loop only
P:
    # Left vertical
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Top horizontal
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Down to mid
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Back to left mid
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy      
    nop
    nop
    nop
    # Travel to baseline-right for spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop
    sub  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy       # (N,0)
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
# Q: O with small tail
Q:
    # O shape
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy   
    nop
    nop
    nop
    # Tail: small horizontal at bottom right
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy   
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $NH
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
# R: like P plus leg down
R:
    # Left vertical, top loop
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy     
    nop
    nop
    nop
    # Leg from mid to baseline-right
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy   
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
# S: three segments (top, mid, bottom)

S:
    # Top horizontal
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy       # (N,N)
    nop
    nop
    nop
    # Mid from right to left
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy    
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy    
    # Bottom horizontal
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy      
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy   
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
# T: top bar + center vertical
T:
    # Top bar centered over baseline
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    sub  $dx, $r0, $NH       # move to left half
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    sub  $xpos, $xpos, $NH
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy      
    nop
    nop
    nop
    add  $dx, $r0, $N        # draw top bar to right
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    # Vertical down from center
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    sub  $dx, $r0, $NH       # go back to center
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy     
    # Spacing: go to right end
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $NH
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
# U: two verticals + bottom bar
U:
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    # Left up
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    # Down again
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Bottom bar to right
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Right vertical
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Back down
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
V:
    # Just like U but without top segment: two short verticals
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    # Left small vertical (N)
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Move to right
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Right small vertical
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
W:
    # Four small verticals: W-like comb
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    # 1st vertical
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    # Move right
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $NH
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # 2nd vertical
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Move right
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $NH
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    # 3rd vertical
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy

    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop

X:
    nop
    nop
    nop
    # Simple cross: two horizontals at top and bottom (approx)
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    # Top bar
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    # Bottom bar
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Spacing to right
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
Y:
    nop
    nop
    nop
    # As a T-like shape
    nop
    nop
    nop
    # Top bar
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    sub  $dx, $r0, $NH
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    sub  $xpos, $xpos, $NH
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Vertical down half
    pen 0
    nop
    nop
    nop
    sub  $dx, $r0, $NH
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $NH
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
Z:
    # Top and bottom bars with a mid link
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    # Top bar
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Travel to mid-left
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    sub  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Mid bar
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    # Bottom bar
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
# DIGITS 0–9  (D0–D9)
D0:
    # Rectangle
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
D1:
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Spacing
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
D2:
nop
nop
nop
    # like S without middle bar complexity
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
D3:

    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop

    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop

    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
D4:
    # half vertical + crossbar + right vertical
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $NH
    nop
    nop
    nop
    add  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $NH
    nop
    nop
    nop
    add  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop

D5:
    # like 2 but mirrored
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
D6:
    # like 0 plus mid bar
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Mid bar

    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $NH
    nop
    nop
    nop
    add  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
D7:
    # top bar + little down stroke
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $N
    nop
    nop
    nop
    sub  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop

    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
D8:
    # like two stacked rectangles
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    # top rectangle
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # bottom rectangle
    
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $NH
    nop
    nop
    nop
    add  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    # Spacing
    
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop
D9:
    # like 6 but top heavy
    nop
    nop
    nop
    pen 1
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    add  $dy, $r0, $N
    nop
    nop
    nop
    add  $ypos, $ypos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    add  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dy, $r0, $NH
    nop
    nop
    nop
    sub  $ypos, $ypos, $NH
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    sub  $dx, $r0, $N
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    sub  $xpos, $xpos, $N
    nop
    nop
    nop
    move $r0, $dx, $dy
    
    # Spacing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop

# SPACE and ENTER

SPACE:
nop
nop
nop
    # Just move right by spacing, no drawing
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
    add  $dx, $r0, $S
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    add  $xpos, $xpos, $S
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    j return_from_letter
    nop
    nop
    nop

nop
nop
nop

nop
nop
nop

ENTER:
nop
nop
nop
    
    nop
    nop
    nop
    pen 0
    nop
    nop
    nop
   
    nop
    nop
    nop
    sub  $dx, $r0, $r0
    nop
    nop
    nop
    sub  $dx, $dx, $dx       
    nop
    nop
    nop
    add  $dy, $r0, $r0
    nop
    nop
    nop
    move $r0, $dx, $dy      
    nop
    nop
    nop

nop
nop
nop
   
    nop
    nop
    nop
    addi $dy, $r0, -100     
    nop
    nop
    nop
    move $r0, $dx, $dy
    nop
    nop
    nop
    sub  $ypos, $ypos, $dy  
    nop
    nop
    nop

nop
nop
nop
    j return_from_letter
    nop
    nop
    nop