.data
dim: .word 20
pos: .word 9
D: .word 0,-1,-2,-3,-4,-5,-6,-7,-8,-9,1,2,3,4,5,6,7,8,9,10
str1: .asciiz "Stampo l'array ordinato:\n"
str2: .asciiz " "

.text
lw $a1, dim
lw $a0, pos
la $a2, D
jal swap
li $v0, 10
syscall

swap:
	li $t1, 0 #indice i di scorrimento del ciclo for
	sll $t2, $a0, 2
	add $t4, $a2, $t2
	lw $t0, 0($t4) #$t0 è la variabile "temp" e contiene il valore di array[k]
	addi $a0, $a0, 1
	sll $t2, $a0, 2
	add $t5, $a2, $t2
	lw $t3, 0($t5) #$t3 contiene il valore di array[k+1]
	sw $t0, 0($t5)
	sw $t3, 0($t4)
	la $a0, str1
	li $v0, 4
	syscall
	
	forloop:
	beq $t1, $a1, exitfor
	lw $a0, 0($a2)
	li $v0, 1
	syscall
	la $a0, str2
	li $v0, 4
	syscall
	la $a2, D
	addi $t1, $t1, 1
	sll $t2, $t1, 2
	add $a2, $t2, $a2
	j forloop
	exitfor:
	jr $ra