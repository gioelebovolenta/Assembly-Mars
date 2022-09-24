.data
n: .word 5

.text
lw $a0, n
jal fact

move $a0, $v0
li $v0, 1
syscall
li $v0, 10
syscall

fact:
#$ra va salvato sullo stack perché altrmenti non riuscirei a tornare al main
#mi devo salvare anche il valore di $a0 perché altrimenti perderei il valore di n, che verrebbe sovrascritto con n-1
#la gestione dello stack è la prima cosa da fare all'ingresso di una procedura

addi $sp, $sp, -8 #incremento lo stack pointer di 8, 4 byte per ogni registro (-8 perché cresce verso il basso)
sw $ra, 4($sp)
sw $a0, 0($sp)

slti $t0, $a0, 1 #if (n<1)
beq $t0, $zero, L1 #se n>=1 salto alla label L1
#return 1
addi $v0, $zero, 1
addi $sp, $sp, 8
jr $ra

L1:
#return n*fact(n-1)
	addi $a0, $a0, -1 #n-1 in $a0
	jal fact
#ripristino di $a0 e $ra
lw $a0, 0($sp) #ripristino di $a0=n
lw $ra, 4($sp) #ripristino l'indirizzo di ritorno al main
addi $sp, $sp, 8

mul $v0, $a0, $v0 #moltiplico n ripristinato (salvato in $a0) con fact(n-1) (salvato in $v0) e lo salvo nel registro di ritorno $v0
jr $ra