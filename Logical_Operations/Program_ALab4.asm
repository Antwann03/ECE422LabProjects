.data
	myMessage: .asciiz "ECE 422L -  Antonio Anzora Jr - Program A \n"
	my1stMessage: .asciiz "1st Integer (Binary):"
	my2ndMessage: .asciiz "2nd Integer (Binary):"
	
	myANDMessage: .asciiz "AND Result: "
	myORMessage: .asciiz "OR Result: "
	myXORMessage: .asciiz "XOR Result: "
	myNORMessage: .asciiz "NOR Result: "

	userPrompt1: .asciiz "Enter the first integer: "
	userPrompt2: .asciiz "Enter the second integer: "
	newLine: .asciiz "\n"
.text
	#Displays my name and the course name
	li $v0, 4
	la $a0, myMessage 
	syscall
	
	#Prompt the user for the first integer
	li $v0, 4
	la $a0, userPrompt1
	syscall
	
	#Read the first integer and by the user and store it in $t0
	li $v0, 5
	syscall
	move $t0, $v0
	
	#Prompt the user for the second integer
	li $v0, 4
	la $a0, userPrompt2
	syscall
	
	#Read the second intger entered by the user and store it in $t1
	li $v0, 5
	syscall
	move $t1, $v0
	
	#Perform an AND operation between $t0 and $t1 and store the result in $t2
	and $t2, $t0, $t1
	
	#Print the first integer in binary
	li $v0, 4
	la $a0, my1stMessage 
	syscall
	li $v0, 35
	move $a0, $t0
	syscall
	
	#Print a newline
	li $v0, 4
	la $a0, newLine
	syscall
	
	#Print the second integer in binary
	li $v0, 4
	la $a0, my2ndMessage 
	syscall
	li $v0, 35
	move $a0, $t1
	syscall
	
	#Print a newLine
	li $v0, 4
	la $a0, newLine
	syscall
	
	#Print the AND result in binary
	li $v0, 4
	la $a0, myANDMessage 
	syscall
	
	li $v0, 35
	move $a0, $t2
	syscall
	
	#Print a newLine
	li $v0, 4
	la $a0, newLine
	syscall
	
	#Print the OR result in binary
	or $t2, $t0, $t1
	
	li $v0, 4
	la $a0, myORMessage
	syscall
	
	li $v0, 35
	move $a0, $t2
	syscall
	
	#Print a newLine
	li $v0, 4
	la $a0, newLine
	syscall
	
	#Print the XOR result in binary
	xor $t4, $t0, $t1
	
	li $v0, 4
	la $a0, myXORMessage
	syscall
	
	li $v0, 35
	move $a0, $t4
	syscall
	
	#Print a newLine
	li $v0, 4
	la $a0, newLine
	syscall
	
	#Print the NOR result in binary
	nor $t5, $t0, $t1
	
	li $v0, 4
	la $a0, myNORMessage
	syscall
	
	li $v0, 35
	move $a0, $t5
	syscall
	
	#Print a newLine
	li $v0, 4
	la $a0, newLine
	syscall
	#Exit the program
	li $v0, 10
	syscall
