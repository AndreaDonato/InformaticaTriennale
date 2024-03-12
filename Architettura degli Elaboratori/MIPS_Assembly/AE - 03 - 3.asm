# selezionare il massimo da un vettore
.globl main

.data
	vector: .word 4, 3, -5, 500
	rez: .word 0
	
.text

main:
	# carichiamo i valori della memoria nei registri
	lw $s0, vector      # A
	lw $s1, vector + 4  # B
	lw $s2, vector + 8  # C
	lw $s3, vector + 12 # D

	and $s4, $s4, $zero # inizializza $s4
    or  $s4, $zero, $s0  # assumo A è il massimo per ora
CheckB:
	slt $t0, $s4, $s1
	beq $t0, $zero, CheckC
	or $s4, $zero, $s1 # il massimo ora è B
CheckC:
	slt $t0, $s4, $s2
	beq $t0, $zero, CheckD
	or $s4, $zero, $s2
CheckD: 
	slt $t0, $s4, $s3
	beq $t0, $zero, End
	or $s4, $zero, $s3
End:
	sw $s4, rez