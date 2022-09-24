.data
arg: .word 4
stringa1: .asciiz "Errore: stai moltiplicando "
stringa2: .asciiz " per "
stringa3: .asciiz "\n il cui risultato è maggiore o uguale di 4.294.967.296"

.text
lw $a0, arg
jal func
move $a0, $v0
li $v0, 1
syscall
li $v0, 10
syscall


func:
li $t0, 1 #gestione di v in $t0
li $t1, 1 #gestione di i in $t1

Forloop:
bgt $t1, $a0, exitforloop
mult $t0, $t1
mflo $t0

mfhi $t2 #inizio gestione dell'overflow
beq $t2, $zero, tuttok
la $a0, stringa1
li $v0, 4
syscall
move $a0, $t0
li $v0, 1
syscall
la $a0, stringa2
li $v0, 4
syscall
move $a0, $t1
li $v0, 1
syscall
la $a0, stringa3
li $v0, 4
syscall
li $v0, 10
syscall #fine gestione dell'overflow

tuttok:
addi $t1, $t1, 1
j Forloop
exitforloop:
move $v0, $t0
jr $ra