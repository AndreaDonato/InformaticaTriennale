.globl hello # careful if you have multiple main in your folder: see Settings PC counter

.data
string: .asciiz "Hello World!" #try with \n
number: .byte 0x02 

.text
hello:
li $v0, 4
la $a0, string
syscall # f4($a0)

li $v0, 1 # print also this number
lb $a0, number
syscall

li $v0, 10
syscall #important for when we have multiple procedures in the file
        # and we want a real exit here
