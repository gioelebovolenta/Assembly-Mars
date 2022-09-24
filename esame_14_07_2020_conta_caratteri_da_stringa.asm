.data
.align 2
str1: .asciiz "Numero di caratteri alfabetici nella stringa vale: "
str2: .asciiz "Numero di cifre nella stringa vale: "
str3: .asciiz "Numero di caratteri speciali nella stringa vale: "
str4: .asciiz "Totale vale "
str5: .asciiz "\n"
str6: .asciiz "esame@ESAME0123456789"

.text
la $a0, str6
li $t0, 0 #totale=0
jal controllacaratteri
move $t0, $v0
la $a0, str4
li $v0, 4
syscall
move $a0, $t0
li $v0, 1
syscall

li $v0, 10
syscall

controllacaratteri:
	li $t1, 0 #alp=0
	li $t2, 0 #digit=0
	li $t3, 0 #splch=0
	li $t4, 0 #i=0
	li $t5, 0
	
	while:
	add $a1, $a0, $t4 #indirizzo di str[i]
	lb $s0 0($a1) #$s0=elemento str[i]
	beq $s0, $t5, exitwhile
	addi $t0, $t0, 1
	
	#if then else statements
	sge $t6, $s0, 0x61 #str[i] >= 'a'?
	sle $t7, $s0, 0x7A #str[i] <= 'z'?
	and $t8, $t6, $t7 #$t8 contiene la prima condizione
	
	sge $t6, $s0, 0x41 #str[i] >= 'A'?
	sle $t7, $s0, 0x5A #str[i] <= 'Z'?
	and $t6, $t6, $t7 #riutilizzo $t6 per avere la seconda condizione
	or $t6, $t6, $t8 #se almeno una delle due vale 1, allora proseguo con alp++
	
	beq $t6, $zero, elseif
	addi $t1, $t1, 1
	j uscitawhile
	elseif:
	sge $t6, $s0, 0x30 #str[i] >= '0'?
	sle $t7, $s0, 0x39 #str[i] <= '9'?
	and $t6, $t6, $t7
	beq $t6, $zero, else
	addi $t2, $t2, 1
	j uscitawhile
	else:
	addi $t3, $t3, 1
	
	uscitawhile:
	addi $t4, $t4, 1
	j while
	
	exitwhile:
	#printf
	la $a0, str1
	li $v0, 4
	syscall #stampa prima stringa
	move $a0, $t1
	li $v0, 1
	syscall #stampa il valore di alp
	
	li $v0, 4
	la $a0, str5
	syscall #stampa "\n"
	la $a0, str2
	syscall #stampa seconda stringa
	move $a0, $t2
	li $v0, 1
	syscall #stampa il valore di digit
	
	li $v0, 4
	la $a0, str5
	syscall #stampa "\n"
	la $a0, str3
	syscall #stampa terza stringa
	move $a0, $t3
	li $v0, 1
	syscall #stampa il valore di splch
	li $v0, 4
	la $a0, str5
	syscall #stampa "\n"
	syscall
	
	move $v0, $t0
	jr $ra