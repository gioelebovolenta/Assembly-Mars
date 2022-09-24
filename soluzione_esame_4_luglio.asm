.data
enter: .asciiz "Enter an integer number: "
result: .asciiz "The square root is "
returndue: .asciiz "\nThe power is "
.text
li $v0, 4
la $a0, enter
syscall
li $v0, 5
syscall
move $a0,$v0
jal sqroot
move $t0, $v0
li $v0, 4
la $a0, result
syscall
move $a0, $t0
li $v0, 1
syscall
jal power
move $t0, $v0
li $v0, 4
la $a0, returndue
syscall
move $a0, $t0
li $v0, 1
syscall
li $v0, 10
syscall


sqroot:
addi $sp, $sp, -4
sw $s0, 0($sp) # x in $s0
li $t0, 0 #index
move $s0, $a0
srl $t1, $a0, 1 # end of counting
forloop:
beq $t0, $t1, escifor
div $t2, $a0, $s0 # n/x
add $t2, $t2, $s0
srl $s0, $t2, 1 # new value of x
addi $t0, $t0, 1
j forloop
escifor:
move $v0, $s0
lw $s0, 0($sp)
addi $sp, $sp, 4
jr $ra

power:
mul $v0, $a0, $a0
jr $ra