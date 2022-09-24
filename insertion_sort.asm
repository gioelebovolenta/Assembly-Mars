.data
n: .word 5
arr: .word 5, 2, 1, 3, 4
sorted: .asciiz "Sorted array is \n"
space: .asciiz " "

.text
la $a0, arr
lw $a1, n
jal insertionsort
li $v0, 4
la $a0, sorted
syscall

la $t0, arr
lw $t1, n
li $t2, 0 #indice i di scorrimento del ciclo for

forloopstampa:
	beq $t2, $t1, exitforloopstampa
	sll $t3, $t2, 2 #scorrimento array 4 byte alla volta
	add $t3, $t3, $t0
	lw $a0, 0($t3) #salvo l'elemento arr[i] in $a0 perché dovrà essere stampato a video
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	addi $t2, $t2, 1
	j forloopstampa
	
exitforloopstampa:
	li $v0, 10
	syscall
	
insertionsort:
addi $sp, $sp, -20 #devo salvare nello stack 5 registri, quindi 5*4 byte ciascuno = 20
sw $ra, 0($sp) #salvo immediatamente il registro $ra, gli altri andranno salvati o poco prima o poco dopo i vari cicli
	
li $t0, 1 #i in $t0
li $t1, 0 #j in $t1

forloop:
	beq $t0, $a1, 	finefor
	move $t1, $t0 #sposto i in j
	whileloop:
	slt $t2, $zero, $t1 #verifica se zero è minore di j, cioè se j è positivo. Se 0<j -> $t2=1. Attenzione a non sovrascrivere $t2
	sll $t3, $t1, 2 #j*4
	add $t3, $t3, $a0 #indirizzo di arr[j] in $t3. Attenzione a non sovrascrivere $t3
	lw $t4, 0($t3) #arr[j] in $t4. Attenzione a non sovrascrivere $t4 perché serve per la condizione aggregata
	addi $t5, $t1, -1 #j-1 in $t5
	sll $t5, $t5, 2 #(j-1)*4 per spostarci in byte lungo l'array
	add $t5, $t5, $a0 #indirizzo di arr[j-1] in $t5. Attenzione a non sovrascrivere $t5
	lw $t6, 0($t5) #arr[j-1] in $t6. Attenzoine a non sovrascrivere $t6 perché serve per la condizione aggregata
	#condizione aggregata
	slt $t4, $t4, $t6 #se arr[j] < arr[j-1], $t4=1. Riutilizzo $t4 perché il valore di arr[j] non mi servirà più
	and $t2, $t2, $t4 #se entrambe le condizioni sono verificate, $t2=1. Riutilizzo di $t2 perché l'esito della sottocondizione non mi serve più. $t2 contiene ora l'esito della condizione aggregata
	beq $t2, $zero, exitwhile
	sw $a0, -4($sp) #salvataggio dei registri $a0 e $a1 nello stack
	sw $a1, -8($sp)
	sw $t0, -16($sp) #salvataggio di $t0 e $t1
	sw $t1, -12($sp)
	add $a0, $zero, $t3 #salvo l'indirizzo di $t3 in $a0, cioè l'indirizzo di arr[j]
	add $a1, $zero, $t5 #salvo l'indirizzo di $t5 in $a1, cioè l'indirizzo di arr[j-1]
	jal invert #chiamata a funzione invert
	lw $a0, -4($sp) #ripristino dei registri $a0, $a1, $t0, $t1
	lw $a1, -8($sp)
	lw $t1, -12($sp)
	lw $t0, -16($sp)
	addi $t1, $t1, -1
	j whileloop
	exitwhile:
	addi $t0, $t0, 1
	j forloop
	finefor:
	lw $ra, 0($sp) #gestione finale dello stack pointer
	addi $sp, $sp, 20
	jr $ra
	
	invert:
	#dovrei gestire lo stakc ma non ce n'è bisogno perché non ci sono altre funzioni innestate all'interno
	#scambiare due valori agli indirizzi di $a0 e $a1 rispettivamente
	lw $t0, 0($a0)
	lw $t1, 0($a1)
	sw $t0, 0($a1)
	sw $t1, 0($a0)
	jr $ra