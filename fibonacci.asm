.text 
 
# a = $s1
# b = $s2

	add $s1, $zero, $zero		# a = 0
	add $s2, $zero, $zero		# b = 0

	addi $s3, $zero, 1		# c = 1
	addi $s4, $zero, 200		# d = 200 
	add $t0, $zero, $zero		# pointer to mem = 0

LOOP:

	sw $s3, 0($t0)			# storing current c in t0
	addi $t0, $t0, 4		# update pointer to next word

	add $s1, $zero, $s2		# a = b
	add $s2, $zero, $s3		# b = c
	
	add $s3, $s1, $s2		# c = a + b

	slt $s5, $s3, $s4		# if c < 200, continue_flag = 1
	bne $s5, $zero, LOOP		# if continue_flag == 1, goto LOOP

STOP:

	add $zero, $zero, $zero
	j STOP