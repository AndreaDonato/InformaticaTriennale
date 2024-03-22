.data
N: .word 0x6369616f # I put 'o'=0x6f as first byte
N2: .byte 0x63,0x69,0x61,0x6f
N3: .byte 'c','i','a','o'
N4: .asciiz "ciao"

.text

lb $t0, N   # this contains 0x6f='o'
lb $t1, N+1 # this 3 ...
lb $t2, N+2
lb $t3, N+3

lw $v0, N

lb $t4, N2   # this contains ?
lb $t5, N2+1 
lb $t6, N2+2
lb $t7, N2+3

lb $s0, N3   # 
lb $s1, N3+1 # 
lb $s2, N3+2
lb $s3, N3+3

lb $s4, N4   # 
lb $s5, N4+1 
lb $s6, N4+2
lb $s7, N4+3
