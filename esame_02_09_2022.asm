.data
str1: .asciiz "Enter a number to check whether prime or not: "
str2: .asciiz "Entered number "
str3: .asciiz " is a prime number."
str4: .asciiz " is not a prime number."

.text
li $t0, 0 #in $t0 carico il valore di "num" (li usata in alternativa ad "addi $t0, $t0, 0", e così anche per le seguenti istruzioni)
li $t1, 0 #in $t1 carico il valore di "i"
li $t2, 0 #in $t2 carico il valore di "flag"
li $t4, 1 #in $t4 carico il valore 1 per verificare se num == 1

la $a0, str1 #stampo la prima stringa che richiede di inserire un numero
li $v0, 4 #syscall 4 di stampa stringa
syscall

li $v0, 5 #syscall 5 per lettura da std input di un intero
syscall

move $t0, $v0 #sposto il valore letto da std input nel registro $t0 che contiene il valore di "num"
#if statement
seq $t3, $t0, $zero #seq per verificare se num == 0
seq $t4, $t0, $t4 #seq per verificare se num == 1, riutilizzo del registro $t4
or $t3, $t3, $t4 #or per la condizione aggregata: if (num == 0 || num == 1), riutilizzo del registro $t3
beq $t3, $zero, nothtodo #se la condizione aggregata dà esito positivo (1), allora imposto il flag a 1
li $t2, 1 #imposto il flag a 1

nothtodo:
li $t1, 2 #inizializzazione di i=2 per il forloop
srl $t3, $t0, 1 #in $t3 ho num/2 utile per verificare la condizione del ciclo for, eseguito tramite una shfit right logical
forloop:
bgt $t1, $t3, exitforloop #se i>num/2 allora esco dal ciclo for
div $t0, $t1 #eseguo la divisione per avere il resto nel registro hi (operazione modulo)
mfhi $t3 #sposto in $t3 il valore presente in hi
bne $t3, $zero, breakif #se il resto è uguale a 0 significa che non si tratta di un numero primo e che quindi il flag va impostato a 1, altrimenti eseguo un'altra iterazione del ciclo for
li $t2, 1 #flag impostato a 1
breakif:
addi $t1, $t1, 1 #i++
j forloop #istruione jump per continuare il ciclo for dopo aver incrementato la variabile i

exitforloop:
la $a0, str2 #stampo la stringa "Entered number "
li $v0, 4 #syscall 4 di stampa stringa
syscall
move $a0, $t0 #sposto il valore letto da std input in $a0 per stamparlo a video
li $v0, 1 #syscall 1 di stampa intero
syscall

bne $t2, $zero, elseif #se flag == 0 (e quindi il numero è primo) alloracontinuo con il codice, altrimenti salto ad elseif (e quindi il numero non è primo)
la $a0, str3 #stampo la stringa " is a prime number."
li $v0, 4 #syscall 4 di stampa stringa
syscall
li $v0, 10 #syscall 10 di terminazione programma
syscall

elseif:
la $a0, str4 #stampo la stringa " is not a prime number."
li $v0, 4 #syscall 4 di stampa stringa
syscall
li $v0, 10 #syscall 10 di terminazione programma
syscall