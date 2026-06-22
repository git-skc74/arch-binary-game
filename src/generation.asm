#		CS2340.501 Term Project
#		Author: Bo Seong Kim
#		Date: 10/19/2025
# 		Description: generate type of problem and return randomly generated problem based on the type

.text
	genType:
		# random 0 or 1
		li $v0, SysRandIntRange
		li $a0, 0
		li $a1, 2 # 0 = binary to decimal, 1 = decimal to binary
		syscall
		
		# store value
		move $t3, $a0
		
		# generate binary if zero, otherwise decimal
		beq $t3, $zero, genBit
		j genDec
		
	genDec:
		# random 0-255
		li $v0, SysRandIntRange
		li $a0, 0
		li $a1, 256
		syscall
		
		# store values and return
		move $v1, $a0
		move $v0, $t3
		jr $ra
			
	genBit:
		li $t1, 0 # counter
		li $t4, 0 # generated bit
		
	genBit_loop:
		# random 0 or 1
		li $v0, SysRandIntRange
		li $a0, 0
		li $a1, 2
		syscall
		
		sll $t4, $t4, 1 # shift one bit to the left
		or $t4, $t4, $a0 # add new bit
		
		addi $t1, $t1, 1 # counter increment by 1
		blt $t1, 8, genBit_loop
		
		# store values and return
		move $v1, $t4
		move $v0, $t3
		jr $ra
