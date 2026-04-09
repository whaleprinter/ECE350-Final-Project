nop
nop
nop
nop
nop
addi $r10, $r0, 5
addi $r11, $r0, 6
nop
nop
nop
bne $r10, $r11, dont_branch
nop
nop
nop
nop
addi $r10, $r10, 1
nop
nop
nop
addi $r21, $r0, 5
bne $r10, $r11, correct_branch
nop
nop
dont_branch:
addi $r20, $r0, 10 # Incorrect
addi $r21, $r21, 10
nop
correct_branch:
addi $r20, $r0, 20
nop
nop
nop