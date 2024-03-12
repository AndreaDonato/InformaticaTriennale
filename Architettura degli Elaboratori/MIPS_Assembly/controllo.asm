.globl main

.data
	vector: .half 2, 5, 7, 3, -10, -7, 1
	#dest: .word caso0, caso1, caso2, caso3		# Mi fa accedere in modo sequenziale a delle etichette (e.g. implemento uno switch)

.text

main:
	j endWhile



##### CICLO WHILE #####

while:
	bge $t1, $t2, endWhile
	j while
	
endWhile:

##### CICLO FOR #####

li $t1, 7		# load immediate, setto il registro $t1 alla costante 7
xor $t0, $t0, $t0	# azzero t0, che uso come counter del ciclo
xor $t3, $t3, $t3	# azzero t3 che uso come accumulatore

for:
	bge $t0, $t1, endFor	# se t1 è greater-equal di t0 ESCO
	# codice da ripetere
	lh $t2, vector+4($t0)	# uso t2 per caricare i valori di vector
	add $t3, $t3, $t2 	# incremento t3 di t2 (t3 += t2)
	addi $t0, $zero, 1	# incremento t0 (i++)
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