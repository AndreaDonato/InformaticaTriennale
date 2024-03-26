.data

N: .word 5
rez: .word 0

.text

lw $a0,N
jal factorial

sw $v0,rez # save result

move $a0,$v0
li $v0,1
syscall

li $v0,10 #exit
syscall

factorial: # factorial($a0: int) : ($v0: int) return the factorial of $a0
	beqz $a0,BaseCase
	
	RecursiveStep: # $a0 * factorial($a0-1)
		subi $sp,$sp,8
		sw $ra,0($sp)
		sw $a0,4($sp)
		
		subi $a0,$a0,1
		jal factorial # from here all the recursive calls are done and the stack is filled,
                      # then from the last call each multiplication is done recovering the value from the stack
		
		lw $a0,4($sp)
		lw $ra,0($sp)
		addi $sp,$sp,8
		
		mul $v0,$v0,$a0

		jr $ra

BaseCase:
	li $v0,1 # 0! is 1 by definition
	jr $ra	