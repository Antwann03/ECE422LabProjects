.data
	message:.asciiz "Result = \n"
.text
	li $t0, 1 #Loads the number 1 into the $t0 register
	
	addi $t0, $t0, 2 #This will add the number 2 into the $t0 register
	addi $t0, $t0, 3 #This will add the number 3 into the $t0 register
	addi $t0, $t0, 4 #This will add the number 4 into the $t0 register
	addi $t0, $t0, 5 #This will add the number 5 into the $t0 register
	
	move $t1, $t0

	#This will print the result or addition
	li $v0, 1
	move $a0, $t1
	syscall
	
	#Finishing the program
	li $v0, 10
	syscall