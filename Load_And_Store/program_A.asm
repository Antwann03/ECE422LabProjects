	#Loading values into registers using load word (lw) & storing values (sw)
	
	#Goal: In the .data section, initialize a .word variable called myVar to zero.
	#Display a prompt for the user to enter a decimal number. Save the  entered
	#value from the user into memory (i.e., assign it to myVar) using the sw
	#instruction. Then, load the value back from memory (i.e., from myVar) 
	#into the $t0 register using lw instruction.
	#Use syscall instruction, print the user value in hexadecimal and binary format.
.data
	#Defines a string
	myMessage: .asciiz "ECE 422L -  Antonio Anzora Jr - Program A \n"
	enterDecimalPrompt: .asciiz "Enter a decimal number: "
	enterHexadecimalPrompt: .asciiz "Hexadecimal: "
	enterBinaryPrompt: .asciiz "Binary: "
	newline: .asciiz "\n"
	
	#Initialize a .word variable called myVar to zero.
	myVar: .word 0
.text
	#Displays my name and the course name
	li $v0, 4
	la $a0, myMessage 
	syscall

	#--------------------------------------------------------------
	li $v0, 4
	la $a0, enterDecimalPrompt 
	syscall

	#Loads a value of 50 into the 
	li $v0, 5
	syscall
	
	sw $v0, myVar
	lw $t0, myVar
	
	#li $v0, 1
	#move $a0, $t0
	#syscall
	
	#----------------------------------------------------------------
	li $v0, 4
	la $a0, enterHexadecimalPrompt 
	syscall
	
	li $v0, 34
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	#---------------------------------------------------------------
	li $v0, 4
	la $a0, enterBinaryPrompt 
	syscall	

	li $v0, 35
	lw $a0, myVar
	syscall
	
	#Exiting the Program
	li $v0, 10
	syscall
