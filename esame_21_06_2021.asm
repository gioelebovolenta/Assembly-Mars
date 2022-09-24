.data
str1: .asciiz "Enter two integers: "
str2: .asciiz "GCD= "

.text
la $a0, str1
li $v0, 4
syscall
li $v0, 5
syscall
move $a0, $v0
li $v0, 5
syscall
move $a1, $v0

#if statement
bgt $a0, $zero, nulladafare
sub $a0, $zero, $a0

nulladafare:
bgt $a1, $zero, nulladafare2
sub $a1, $zero, $a1

nulladafare2:
#continuo il codice
jal computegcd
move $t0, $v0
la $a0, str2
li $v0, 4
syscall
move $a0, $t0
li $v0, 1
syscall
li $v0, 10
syscall

computegcd:
	whileloop:
	beq $a0, $a1, exitwhile
	
	bgt $a0, $a1, ramothen
	sub $a1, $a1, $a0
	
	j whileloop
	ramothen:
	sub $a0, $a0, $a1
	
	j whileloop
	exitwhile:
	move $v0, $a0
	jr $ra