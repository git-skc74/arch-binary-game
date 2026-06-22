#		CS2340.501 Term Project
#		Author: Bo Seong Kim
#		Date: 10/19/2025
# 		Description: main file for binary game

.include "SysCalls.asm"

.data
	max_level: .word 10
	buffer: .space 16
	
	welcome: .asciiz "Welcome to Binary Game!\n"
	level_complete: .asciiz "Level Complete!\n"
	game_complete: .asciiz "\nGame Complete!\nThank you for playing\n"
	
	level: .asciiz "\nLevel "
	newline: .asciiz "\n"

	enter_integer: .asciiz "Enter your answer (Decimal): "
	enter_string: .asciiz "Enter your answer (8-bit Binary): "
	
	try_again: .asciiz "\nIncorrect, try again!\n"
	correct_answer: .asciiz "\nCorrect!\n"
	
.text
	main:
		# print welcome message
		li $v0, SysPrintString
		la $a0, welcome
		syscall 
	
		li $s0, 1 # current level = 1
		lw $s7, max_level # max level = 10
		li $s1, 0 # score = 0
		 
	level_start:	
		# print level message
		li $v0, SysPrintString
		la $a0, level
		syscall 
		# print current level value
		li $v0, SysPrintInt
		move $a0, $s0
		syscall
		# print newline
		li $v0, SysPrintString
		la $a0, newline
		syscall
		
		# level n = n problems (level 2 has 2 problems...)
		 li $t0, 0 # reset number of problems completed 
		
	problem_loop:
		beq $t0, $s0, end_level # end level if counter = current level
		
		# randomly select type of problem and generate random problem
		jal genType # jump and link to genType
		
		move $t1, $v0 # $t1 = type of problem
		move $t2, $v1 # save the problem value to $t2
		
		move $a0, $t1 # move type of problem to parameter $a0
		move $a1, $t2 # move problem value to parameter $a1
		jal drawBoard # jump and link to drawBoard
	
	input:
		# check type of question
		beq $t1, $zero, integer_input
		j string_input
		
	integer_input:
		# prompt user to enter the answer
		li $v0, SysPrintString
		la $a0, enter_integer
		syscall 
		
		# collect user input - decimal
		li $v0, SysReadInt
		syscall
		move $t3, $v0
		
		j validate_answer
		
	string_input:
		# prompt user to enter the answer
		li $v0, SysPrintString
		la $a0, enter_string
		syscall 
		
		# collect user input - binary
		li $v0, SysReadString
		la $a0, buffer
		li $a1, 16
		syscall
		move $t3, $a0
		
	validate_answer:
		move $a0, $t1 # move type of problem to parameter $a0
		move $a1, $t2 # move problem value to parameter $a1
		move $a2, $t3 # move the answer to parameter $a2
		
		jal validation
		
		# if it's valid (1), complete the problem; otherwise loop again
		beq $v0, 1, problem_complete

		# If incorrect, prompt again
   	 	li $v0, SysPrintString
    		la $a0, try_again
    		syscall
    		j input

	problem_complete:
		# indicate it's correct
		li $v0, SysPrintString
		la $a0, correct_answer
		syscall 
		
		# problem counter increment
		addi $t0, $t0, 1
		j problem_loop
	
	end_level:
		# display level complete message
		li $v0, SysPrintString
		la $a0, level_complete
		syscall 
		
		addi $s0, $s0, 1 # current level + 1
		ble $s0, $s7, level_start
		
	end_game:
		# display game completed
		li $v0, SysPrintString
		la $a0, game_complete
		syscall 
		
		# end game
		li $v0, SysExit
		syscall
		
.include "board.asm"
.include "generation.asm"
.include "validation.asm"