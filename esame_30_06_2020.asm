.data
max_size: .word 10
size_small: .word 2
a: .word 9,-8,5,4,-2,5,-3,-1,0,6
b: .word 1,-1
c: .space 8
str1: .asciiz "\n"

.text
lw $t0, max_size
lw $a0, size_small
la $a1, a
la $a2, b
la $a3, c
jal convoluzione
li $v0, 10
syscall

convoluzione:
	addi $sp, $sp, -4
	sw $ra, 4($sp)
	
	
	addi $t0, $t0, -1
	li $t1, 0 #indice  i di scorrimento primo forloop
	li $t2, 0 #indice k di scorrimento secondo forloop
	move $t3, $a0 #sposto il contenuto di size_small in $t3 per evitare che venga sovrascritto dall'argomento che dovrò passare alla syscall
	primofor:
	beq $t1, $t0, fineprimofor
	#body primo forloop
	secondofor:
	beq $t2, $t3, finesecondofor
	#body secondo for
	sll $t4, $t2, 2 #$t4=offset del k-esimo elemento NON SOVRASCRIVERE
	add $t5, $a2, $t4 #$t5=indirizzo di bb[k]
	lw $s0, 0($t5) #$s0=elemento bb[k]
	add $t7, $a3, $t4 #$t7=indirizzo di tt[k]
	sll $t6, $t1, 2 #$t6=offset dell' i-esimo elemento NON SOVRASCRIVERE
	add $t5, $t6, $t4 #RIUTILIZZO $t5=offset del k+i-esimo elemento
	add $t8, $a1, $t5 #$t8=indirizzo di aa[k+i]
	lw $s1, 0($t8) #$s1=elemento aa[k+i]
	mul $s2, $s0, $s1 #aa[k+i]*bb[k]
	sw $s2, 0($t7) #$s2=elemento tt[k] 	
	
	
	
	
	addi $t2, $t2, 1
	j secondofor
	finesecondofor:
	li $t2, 0
	jal somma
	move $t5, $v0
	la $a0, str1
	li $v0, 4
	syscall
	move $a0, $t5
	li $v0, 1
	syscall
	la $a0, str1
	li $v0, 4
	syscall
	addi $t1, $t1, 1
	j primofor
	fineprimofor:
	lw $ra, 4($sp)
	addi $sp, $sp, 4
	jr $ra	
	
	somma:
	li $t5, 0 #int somma=0
	li $t7, 0 #indice i di scorrimento forloop
	forloopsomma:
	beq $t7, $t3, exitforloopsomma
	sll $t8, $t7, 2
	add $t8, $a3, $t8
	lw $s0, 0($t8)
	add $t5, $t5, $s0
	addi $t7, $t7, 1
	j forloopsomma
	exitforloopsomma:
	move $v0, $t5
	jr $ra