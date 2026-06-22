#		CS2340.501 Term Project
#		Author: Bo Seong Kim
#		Date: 10/19/2025
# 		Description: convert binary to decimal and return the converted number

.text
	# input: $a0 = binary string (ex: "11111110\n")
	# output: $v0 = decimal value (ex: 254)

	convert_b2d:
		li   $v0, 0           # reset output

	b2d_loop:
		lb   $t8, 0($a0)          # load current character
		beq  $t8, $zero, b2d_done # end if null terminator (\0)

		li   $t9, '\n'            # end if newline (\n)
		beq  $t8, $t9, b2d_done

		li   $t9, '0'
		beq  $t8, $t9, add_zero

		li   $t9, '1'
		beq  $t8, $t9, add_one

		# ignore non-binary characters
		addi $a0, $a0, 1
		j    b2d_loop

	add_zero:
		sll  $v0, $v0, 1      # v0 = v0 * 2
		addi $a0, $a0, 1
		j    b2d_loop

	add_one:
		sll  $v0, $v0, 1
		addi $v0, $v0, 1      # add 1 to last bit
		addi $a0, $a0, 1
		j    b2d_loop

	b2d_done:
		jr   $ra