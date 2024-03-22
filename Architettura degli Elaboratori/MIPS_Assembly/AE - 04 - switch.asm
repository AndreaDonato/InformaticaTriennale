.text
	li $t0, 1           # voglio saltare a caso1
	sll $t0, $t0, 2		# A*4
	lw $t1, dest($t0)	# carico indirizzo +$t0
	jr $t1				# salto a registro

caso0:	# codice del caso 0
	j endSwitch
caso1:	# codice del caso 1
	move $t2,$t1
	j endSwitch
# altri casi
caso2:	# codice del caso N
	j endSwitch
endSwitch:
	# codice seguente

.data
dest: 	.word caso0, caso1, caso2

