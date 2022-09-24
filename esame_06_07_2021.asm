.data
str1: .asciiz "\n"
str2: .asciiz " "

.text
li $a0, 6 # $a0 = maxi
li $a1, 20 # $a1 = maxj
jal counter
li $v0, 10
syscall

counter:
	li $t0, 1 # $t0 = i
	li $t2, 5 # $t2 = 5 utile per eseguire l'operazione modulo nel secondo while
	addi $sp, $sp, -4
	sw $a0, 0($sp)
	firstwhile:
	bgt $t0, $a0, exitfirstwhile # while (i<=maxi)
	
	li $t1, 1 # $t1 = j = 1
	secondwhile:
	bgt $t1, $a1, exitsecondwhile # while (j<=maxj)
	div $t1, $t2 # j % 5
	mfhi $t3
	bne $t3, $zero, nothtodo # if (j%5==0)
	la $a0, str1 # printf("\n")
	li $v0, 4
	syscall
	nothtodo:
	move $a0, $t1
	li $v0, 1 # printf("%d ", j)
	syscall
	la $a0, str2
	li $v0, 4
	syscall
	addi $t1, $t1, 1 # j++
	j secondwhile
	exitsecondwhile:
	la $a0, str1 # printf ("\n")
	li $v0, 4
	syscall
	lw $a0, 0($sp)
	addi $t0, $t0, 1 # i++
	j firstwhile
	exitfirstwhile:
	addi $sp, $sp, 4
	jr $ra