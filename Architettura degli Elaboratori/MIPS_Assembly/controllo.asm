.globl main

.data	# di base tramite le etichette dichiaro le variabili
	vector: .byte 2, 5, 7, 3, -10, -7, 1
	zeri: .word 0:10 				# alloca 10 indirizzi e li setta a 0
	#dest: .word caso0, caso1, caso2, caso3		# Mi fa accedere in modo sequenziale a delle etichette (e.g. implemento uno switch)
.text

main:
	j while



##### CICLO WHILE #####

xor $t1, $t1, $t1 	# azzero t1 per portarlo a 7 e creare la lunghezza del vettore

while:
	bge $t1, 7, endWhile
	addi $t1, $t1, 1
	j while
	
endWhile:



##### CICLO FOR #####

# li $t1, 7		# load immediate, setto il registro $t1 alla costante 7 (lunghezza di vector) * lunghezza word (4, 2 half-word, 1 byte)
sll $t1, $t1, 0 	# OPPURE visto che l'ho già costruito con la lunghezza di vector faccio uno shift logico left di 0 (byte), 1 (half) o 2 (word), ovvero moltiplico per 1, 2 o 4.  
xor $t0, $t0, $t0	# azzero t0, che uso come counter del ciclo
xor $t3, $t3, $t3	# azzero t3 che uso come accumulatore

for:
	# CONDIZIONE #
	bge $t0, $t1, endFor	# se t1 è greater-equal di t0 ESCO

	# CORPO #
	la $t9, vector($t0) 	# carico in t9 l'indirizzo vector+t0	
	lb $t2, ($t9)		# uso t2 per caricare i valori di vector
	add $t3, $t3, $t2 	# incremento t3 di t2 (t3 += t2)
	addi $t0, $t0, 1	# incremento t0 (i++) di (1 se il vettore è byte, 2 se è half, 4 se è word)
	j for 			# se sono arrivato in fondo devo ricominciare richiamo l'etichetta del for
endFor:
	j endSwitch


##### SWITCH #####

switch:
	caso0:
		# Codice caso0
		j endSwitch
	caso1:
		# Codice caso1
		j endSwitch
		
endSwitch:
