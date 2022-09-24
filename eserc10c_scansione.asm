.data
array: .word 10,11,13,14,17,9,7,1,4,99
size: .word 10
SDR: .asciiz "Il maggiore vale \n"

.text
Main:
lw $a0, size
la $a1, array
jal trovamaggiore

add $t0, $v0, $zero # mi salvo il valore di ritorno
# perchè lo vado a sovrascrivere
# per chiamare una syscall

la $a0, SDR
li $v0, 4
syscall
add $a0, $t0, $zero
li $v0, 1
syscall
li $v0, 10
syscall

trovamaggiore:

li $t3, 0 # indice in byte dell’array e riutilizzo per l’indirizzo assoluto del primo elemento
li $t2, 0 # memorizza il maggiore
li $t1, 0 # memorizza gli elementi dell’array
li $t0, 0 # indice di scorrimento dell'array
Forloop:

beq $t0, $a0, Endforloop # se l’indice corrisponde al numero di elementi, esco
sll $t3, $t0, 2 # formo l'indice per byte
add $t3, $a1, $t3 # indirizzo elemento
lw $t1, 0($t3)
# if-then-else
slt $t4, $t1, $t2 # $t4 vale 1 se temp < maggiore
bne $t4, $zero, nulladafare
add $t2, $t1, $zero #aggiorna il max.

nulladafare:

addi $t0, $t0, 1
j Forloop

Endforloop:

add $v0, $t2, $zero
jr $ra