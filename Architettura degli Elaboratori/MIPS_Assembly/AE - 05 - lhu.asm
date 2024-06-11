.data
N: .half 0xFFFF
M: .half 1

.text

lhu $t1, N
lh $t2, N

lhu $t3, M
lh $t4, M

#come si può vedere il problema si presenta solo quando il MSB è 1 (sign extension)