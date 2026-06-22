#		CS2340.501 Term Project
#		Author: Bo Seong Kim
#		Date: 10/19/2025
# 		Description: validate user input and return whether the answer is correct or not

.text
	validation:
		move $t4, $a0 # problem type
		move $t5, $a1 # problem value
		move $t6, $a2 # user input
		
		# save return address and problem type in stack
		addi $sp, $sp, -8
		sw $ra, 4($sp)
		sw $t4, 0($sp)
		
		# b2d if zero; otherwise d2b
		beq $t4, $zero, validate_b2d
		j validate_d2b
		
	validate_b2d:
		# branch if correct; otherwise incorrect
		beq $t5, $t6, correct
		j incorrect
		
	validate_d2b:
		# call convert_b2d function to convert the input
		move $a0, $t6
		jal convert_b2d
		
		move $t7, $v0
		
		# branch if correct; otherwise incorrect
		beq $t5, $t7, correct
		j incorrect
		
	correct:
		# restore stack
		lw $ra, 4($sp)
		lw $t4, 0($sp)
    		addi $sp, $sp, 8
    		
    		# return
		li $v0, 1
		jr $ra
	
	incorrect:
		# restore stack
		lw $ra, 4($sp)
		lw $t4, 0($sp)
    		addi $sp, $sp, 8
    		
    		# return
		li $v0, 0
		jr $ra

.include "conversion.asm"