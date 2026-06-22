#		CS2340.501 Term Project
#		Author: Bo Seong Kim
#		Date: 10/19/2025
# 		Description: draw board based in ASCII

.data
	msg_b2d: .asciiz "\nConvert Binary to Decimal"
	msg_d2b: .asciiz "\nConvert Decimal to Binary"
	border: .asciiz "\n+----+----+----+----+----+----+----+----+\n"
	empty_binary: .asciiz "  |  ?  |  ?  |  ?  |  ?  |  ?  |  ?  |  ?  |  ?  |   =  "
	helper: .asciiz " 128   64   32   16    8     4     2     1\n"
	pipe: .asciiz "  |  "
.text
	drawBoard:
		move $t4, $a0 # problem type
		move $t5, $a1 # problem value
		
		beq $t4, $zero, print_binary
		b print_decimal

	print_decimal:
		# print instruction
		li $v0, SysPrintString
		la $a0, msg_d2b
		syscall
		
		# print top border
		li $v0, SysPrintString
		la $a0, border
		syscall
		
		# display empty template
		li $v0, SysPrintString
		la $a0, empty_binary
		syscall
		
		# display decimal value
		li $v0, SysPrintInt
		move $a0, $t5
		syscall
		
		j end_drawBoard
		
	print_binary:
		# print instruction
		li $v0, SysPrintString
		la $a0, msg_b2d
		syscall
		
		# print border	
		li $v0, SysPrintString
		la $a0, border
		syscall
		
		# print a pipe before the first number
		li $v0, SysPrintString
		la $a0, pipe
		syscall
		
		li $t6, 128 # bit mask starting at 2^7 = 128
		
	print_binary_loop:
		# check current bit using AND
		and $t7, $t5, $t6
		beq $t7, $zero, print_zero # print '0' if bit == 0
		
		li $a0, '1'
		j print_bit_done
		
	print_zero:
		li $a0, '0'
		
	print_bit_done:
		# print the bit
		li $v0, SysPrintChar
		syscall
		
		# print the pipes
		li $v0, SysPrintString
		la $a0, pipe
		syscall
		
		# shift mask to next bit (right)
		srl $t6, $t6, 1
		bne $t6, $zero, print_binary_loop # continues until last bit
		
	end_drawBoard:
		# print bottom border
		li $v0, SysPrintString
		la $a0, border
		syscall
		
		# print helper
		li $v0, SysPrintString
		la $a0, helper
		syscall
		
		jr $ra

