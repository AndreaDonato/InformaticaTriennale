.globl main


.data
	A:	.double	1.23456789		# Meglio usare lettere maiuscole, le minuscole rischiano di essere istruzioni
	B: 	.double	9.87654321
	C:	.double 100.99887766554433	# ... 2211 non entrano. Questa è la massima precisione del double


.text
main:

	### Convenzione per i registri del COPROCESSORE 1 per questo programma
	###     Registri da %f0 a f10   : CALLER SAVE (Temporanei)
	### 	Registri da %f12 a %f18 : CALLEE SAVE (Importanti)
	###	Registri da %f20 a %f26 : PARAMETRI A FUNZIONE
	### 	Registri   %f28 e %f30  : RITORNO DA FUNZIONE
	
 	l.d $f20, A	# Metto i parametri nei registri per il passaggio a funzione
	l.d $f22, B 	# Se uso i double (... ho istruzioni dedicate) il processore dedica due registri del Coprocessore 1
	l.d $f24, C	# Quindi devo saltare di due in due!

	jal LinearEquation	# Chiama la funzione che calcola x t.c. Ax + B = 0;
	mov.d $f20, $f28	# E salva il risultato in $f20, perché voglio darlo in pasto alla funzione che lo stampa

	jal PrintDouble 	# Chiama la funzione che stampa il risultato di Linear Equation
	
	xor $s0, $s0, $s0
	li $v0, 1              # System call function selector: print int
	add $a0, $s0, $zero   # System call parameter passage
	syscall

	li $v0,10             # Exit
	syscall


LinearEquation:
### SEGNATURA IN STILE C --> double LinearEquation($f20 double, $f22 double); 	###
### VALORI DI RITORNO -----> $f28 = x t.c. ($f20)x + ($f22) = 0  	 	###

### Non ci sono funzioni annidate, nè abbastanza variabili da richiedere l'uso di registri Callee-Save. Non uso la Stack.

	div.d $f28, $f22, $f20 	# Divido
	neg.d $f28, $f28 	# Cambio segno (per ora non so se ci sono modi più intelligenti di questa pseudoistruzione)
	jr $ra 			# Torno al chiamante


PrintDouble:
### SEGNATURA IN STILE C --> void PrintDouble($f20 double); 			###
### VALORI DI RITORNO -----> Stampa su STDOUT il valore di $f20			###

### In MIPS Assembly non esiste una serie di istruzioni standard di tipo syscall per stampare un double, quindi devo convertirlo in stringa. 
	l.d $f20, A
	cvt.w.d $f2, $f20
	mfc1.d $t2, $f20
	trunc.w.s $f0, $f20
	jr $ra

### Salva stato dei registri ###
# In caso di funzioni annidate all'interno dovrei fare il primo subi, e aggiungere i registri usati come variabili all'interno
# subi $sp, $sp, 20   # Abbasso lo Stack Pointer di [2 (indirizzi di ritorno e della funzione) + 2 (parametri passati)] * 4 (in questo caso sono tutte delle word) = 16

#	subi $sp, $sp, 
#	sw $ra,  0($sp)     # First: save the return address (così se chiamo una funzione annidata non mi perdo dove devo tornare) [QUI NON SERVE!]
#  	sw $fp,  0($sp)     # Save the frame (function) pointer. Though not used, really.
#  	sw $a0,  8($sp)     # Save the parameters (potrei usare questi registri per una funzione annidata)
#  	sw $a1, 12($sp)
#  	sw $s0, 16($sp)     # Save $s0, as it is also used locally # NON USATO!

### Corpo di Cristo (amen) ###



### Ripristina stato dei registri ###
#  lw $s0,  16($sp)    # Recover the registers, in reverse order
#  lw $a1,  12($sp)
#  lw $a0,  8($sp)
#  lw $fp,  4($sp)
#  lw $ra,  0($sp)
 # addi $sp, $sp, 20   # Roll the stack pointer back up

#  jr $ra              # Jump back to the invocation point
