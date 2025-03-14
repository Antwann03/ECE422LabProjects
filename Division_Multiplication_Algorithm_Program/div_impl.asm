.data
	myNameMessage: .asciiz "ECE 422L - Antonio Anzora Jr - Division Algorithm\n"
	EnterDividendMessage: .asciiz "Enter the dividend (0-255):"
	EnterDivisorMessage: .asciiz "Enter the divisor (1-255):"
	printDividend: .asciiz "Dividend: "
	printDivisor: .asciiz "Divisor: "
	printQuotientMessage: .asciiz "The quotient is: "
	printRemainderMessage: .asciiz "The remainder is: "
	newLine: .asciiz "\n"
	printErrorDivideByZero: .asciiz " Error! Division by zero is not allowed. "
	printErrorMessage: .asciiz "Error! One of the values exceeds 8 bits."
.text
	#Display Course Name, Project Name, and My Name
	li $v0, 4
	la $a0, myNameMessage
	syscall
	
	#Display the Prompt for the Dividend Message
	li $v0, 4
	la $a0, EnterDividendMessage
	syscall
	
	#Reading the input user value
	li $v0, 5
	syscall
	move $t0, $v0
	
	#Display the Prompt Divisor Message
	li $v0, 4
	la $a0, EnterDivisorMessage
	syscall
	
	#Reading the prompt user value
	li $v0, 5
	syscall
	move $t1, $v0
	
	#Disiplay the Dividend Message with the entered value
	li $v0, 4
	la $a0, printDividend
	syscall
	#Reading the integer value input into the $t0 register
	li $v0, 1
	move $a0, $t0
	syscall
	#Display a newLine
	li $v0, 4
	la $a0, newLine
	syscall
	
	#Display the Divisor Message with the entered value
	li $v0, 4
	la $a0, printDivisor
	syscall
	#Reading the integer value input into the $t1 register
	li $v0, 1
	move $a0, $t1
	syscall
	#Display a newLine
	li $v0, 4
	la $a0, newLine
	syscall
	
	#Checking if the value is greater than 255; if so print error message
	li $t2, 255
	#if dividend input is greataer than 255, print the error
	bgt $t0, $t2, errorMessageProgram
	#if divisor input is greater than 255, print error
	bgt $t1, $t2, errorMessageProgram
	#Checking if the input divisor is 0
	beq $t1, $zero, errorDivisionByZero
	#Dividend = 0; than so qoutient and remainder
	beq $t0, $zero, zeroDividend
	
	#Quotient 
	move $t2, $zero
	#Remainder
	move $t3, $t0	

divisionProcess:
	#Checking if remainder is greater than divisor 
	blt $t3, $t1, divisionSuccess
	#Subtract Divisor from remainder
	sub $t3, $t3, $t1
	#Incrementing the quotient
	addi $t2, $t2, 1
	#NonStop until remainder is greate than divisor
	j divisionProcess
	
divisionSuccess:
	#Print the Quotient Message Prompt
	li $v0, 4
	la $a0, printQuotientMessage
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
	#Print newLine
	li $v0, 4
	la $a0, newLine
	syscall
	
	#Print the remainder
	li $v0, 4
	la $a0, printRemainderMessage
	syscall
	li $v0, 1
	move $a0, $t3
	syscall
	#Print newLine
	li $v0, 4
	la $a0, newLine
	syscall
	#Exit the Program
	li $v0, 10
	syscall
	
errorMessageProgram:
	#Printing the error message if the user inputs a value greater than 255
	li $v0, 4
	la $a0, printErrorMessage
	syscall
	#Exit the Program
	li $v0, 10
	syscall
	
errorDivisionByZero:
	#Printing the error message when thers input of zero 
	li $v0, 4
	la $a0, printErrorDivideByZero
	syscall
	#Exit the PRogram
	li $v0, 10
	syscall
	
zeroDividend:
	#Printing the Qoutient prompt
	li $v0, 4
	la $a0, printQuotientMessage
	syscall
	li $a0, 0
	li $v0, 1
	syscall
	#Print newLine
	li $v0, 4
	la $a0, newLine
	syscall
	
	#Printing the Remainder Prompt
	li $v0, 4
	la $a0, printRemainderMessage
	syscall
	li $a0, 0
	li $v0, 1
	syscall
	#Print newLine
	li $v0, 4
	la $a0, newLine
	syscall