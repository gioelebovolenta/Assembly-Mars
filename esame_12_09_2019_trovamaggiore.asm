.data
dim: .word 4
A: .word 2, 1, 3, 2
str1: .asciiz "Il valore ritornato dalla procedura vale "

.text
la $a0, A
lw $a1, dim
jal procedura
move $t0, $v0
la $a0, str1
li $v0, 4
syscall
move $a0, $t0
li $v0, 1
syscall
li $v0, 10
syscall

procedura:
	lw $t0, 0($a0) #registro che memorizza la variabile "a" che tiene il valore massimo
	move $t1, $t0 #registro che memorizza gli elementi dell'array v
	li $t2, 0 #indice in byte dello scorrimento dell'array
	#$a1 tiene la dimensione dell'array: è quindi l'indice di scorrimento
	
	whileloop:
	addi $a1, $a1, -1
	ble $a1, $zero, finewhile
	sll $t2, $a1, 2
	add $t2, $a0, $t2
	lw $t1, 0($t2)
	ble $t1, $t0, nulladafare
	move $t0, $t1
	
	nulladafare:
	j whileloop
	
	finewhile:
	move $v0, $t0
	jr $ra