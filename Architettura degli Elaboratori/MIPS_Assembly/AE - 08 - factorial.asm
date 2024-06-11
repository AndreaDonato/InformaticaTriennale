# factorial N!

.data

N: .word 5
rez: .word 0

.text

lw $a0,N
jal factorial #these two call F(N)

move $a0,$v0
li $v0,1
syscall

li $v0, 10 # se dimentichiamo questo andiamo in un ciclo infinito
syscall

factorial:
subi $sp,$sp,4 #lo stack LO SCRIVO ALLA FINE
sw $a0,0($sp) # In realtà $a0 non va conservato!

li $v0,1 # neutro per la moltiplicazione

While:
	beqz $a0,EndWhile
	mul $v0,$v0,$a0
	sub $a0,$a0,1
	j While
	
EndWhile:
sw $v0,rez

lw $a0,0($sp)
addi $sp,$sp,4  # se mi dimentico questo ho un memory leak
jr $ra

