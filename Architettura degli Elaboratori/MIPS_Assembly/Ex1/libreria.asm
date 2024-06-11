### L'ASSEMBLER MIPS NON ESEGUE IL LINKING DEI MODULI 			###
### Al momento penso sia impossibile far funzionare le liberire 	###
### Amen 								###


.globl PrintDouble
.data
	COMMA: 		.asciiz ","
	
	
PrintDouble:
### SEGNATURA IN STILE C --> void PrintDouble($f20 double); 			###
### VALORI DI RITORNO -----> Stampa su STDOUT il valore di $f20			###

### In MIPS Assembly non esiste una serie di istruzioni standard di tipo syscall per stampare un double, quindi devo convertirlo in stringa.
	
	# PARTE INTERA
	trunc.w.d $f2, $f20 	# Tronco la parte intera di $f20 e la metto in $f2, che contiene ora un intero a 32bit (ma ancora rappresentato come double!!)
	mfc1.d $a0, $f2		# Salvo il contenuto di $f2 in un registro intero $a0, che lo interpreterà correttamente
	
	# ... CHE INTANTO STAMPO INSIEME ALLA VIRGOLA
	li $v0, 1		# Codice syscall stampa intero
    	syscall
    	li $v0, 4
    	la $a0, COMMA
    	syscall
    	
	# PARTE DECIMALE
	cvt.d.w $f2, $f2 	# Converto quella roba strana che era $f2 in un vero intero rappresentato come double
	sub.d $f4, $f20, $f2	# Salvo in $f4 la parte decimale
	l.d $f0, PRECISION 	# Carico la precisione di stampa
	mul.d $f4, $f4, $f0	# Ora PRECISION cifre della parte decimale del numero da stampare sono rappresentate come numero intero in $f4
	trunc.w.d $f2, $f4 	# Tronco la parte intera di $f4 e la metto in $f2
	mfc1.d $a0, $f2		# Salvo la parte intera di $f2 (Ovvero PRECISION cifre della parte decimale bla bla bla) in un registro intero $t2

	# STAMPO LA PARTE DECIMALE
	li $v0, 1
    	syscall
	
	jr $ra
