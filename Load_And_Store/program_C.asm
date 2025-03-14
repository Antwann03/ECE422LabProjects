.data
	myName:		.asciiz "ECE 422L -  Antonio Anzora Jr - Program C \n"
	#Initialize the array
	myMessage: 	.asciiz "Array Elements:"
	#Define the size of the array
	myArray:	.word 10, 20, 30, 40, 50, 60, 70, 80
	arrayLength: 	.word 8
	mySum:		.asciiz "\nSum of Array Elements:"
.text
	#Print the course and name message
	li $v0, 4
	la $a0, myName
	syscall
	
	li $v0, 4
	la $a0, myMessage
	syscall
	
	#Load the base address of myArray into $t0
	la $t0, myArray
	#Load the size of the array into $t1
	lw $t1, arrayLength
	#Initialize $t2 as a counter for a loop
	li $t2, 0
	
loop:
	#If the counter ($t2) is equal to arrayLength ($t1), then exit the loop
	beq $t2, $t1, sum
	#Load the current array element into $t3
	lw $t3, 0($t0)
	#Syscall code for printing an integer
	li $v0, 1
	move $a0, $t3
	syscall
	
	#Syscall code for printing a space
	li $v0, 11
	#ASCII code for the space character
	li $a0, 32
	syscall
	
	#Adds the array elements to the sum ; similar to program_B concept ($t4 = $t4 + val)
	add $t4, $t4, $t3 
	
	#Move to the next element in the array (each word is 4 bytes)
	addi $t0, $t0, 4
	#Increment the loop counter
	addi $t2, $t2,1
	j loop
	
sum:
	li $v0, 4
	la $a0, mySum
	syscall
	#Syscall code for printing integer 
	li $v0, 1
	move $a0, $t4
	syscall
	
	
exit:	#Exit the program
	li $v0, 10
	syscall
	