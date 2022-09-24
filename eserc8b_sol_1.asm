.data
a: .space 4 #int a
b: .space 4 #int b
strinput: .asciiz "Inserisci un numero: "
outputstringpari: .asciiz "\nIl numero è pari."
outputstringdispari: .asciiz "\nIl numero è dispari."

.text
main:
	li $v0, 4
	la $a0, strinput
	syscall
	
	li $v0, 5 #il valore letto sarà memorizzato in $v0
	syscall
	
	move $a0, $v0
	jal paridispari
	
	move $t0, $v0 #travaso del valore di ritorno da $v0 in $t0, così posso usare liberamente le syscall
	li $v0, 4
	beq $t0, $zero, parimain
	#li $v0, 4
	la $a0, outputstringdispari
	syscall
	j exitmain
	
parimain:
	#li $v0, 4
	la $a0, outputstringpari
	syscall

exitmain:
	li $v0, 10
	syscall

paridispari:
	li $t0, 2
	div $a0, $t0 #$a0 diviso 2: il risultato della divisione va in LO, mentre il resto va in HI
	mfhi $t0 #move from hi
	beq $t0, $zero, pari #confronto il resto della divisione in $t0 con $zero: se è 0 mi sposto in "pari"
	li $v0, 1 #ritorna 1 se dispari
	j exit
	
pari:
	li $v0, 0 #ritorna 0 se pari
exit:
	jr $ra