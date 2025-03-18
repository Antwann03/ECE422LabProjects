.data
	myNameandCourseName: .asciiz "ECE 422L - Antonio Anzora Jr - Calculaor Design\n"
	enterFirstVal: .asciiz "Enter the first value (0-255): "
	enterSecondVal: .asciiz "Enter the second value (0-255): "
	enterOperator: .asciiz "Enter Operator (+, -, *, /): "
	printResult: .asciiz "\nThe result is: "
	printnewLine: .asciiz "\n"
	printErrorExceeds: .asciiz "\nError! One of the values exceeds 8 bits."
	printInvalidOperator: .asciiz "\nInvalid operator entered."
	printErrorDividedByZero: .asciiz "\nError: Division by zero is not allowed."
	printErrorUnsignedSubtraction: .asciiz "\nCannot subtract a larger number from a smaller number (unsigned)."
	printRemainder: .asciiz "\nThe Remainder is: "
	printQuotient: .asciiz "The Quotient is: "
.text
main:
	#Display Course, Project, and my Name (Display Program Title)
	li $v0, 4
	la $a0, myNameandCourseName
	syscall
	
	#Display the Prompt to enter the first prompt
	la $a0, enterFirstVal
	#Read the first input number
	jal get_input
	#Stores the number from the user into $t0 register
	move $t0, $v0
	
	#Checking for the input if it will be greater than 255 at $t0 register
	jal check_input
	
	#Display the Prompt to ener the second prompt
	la $a0, enterSecondVal
	#Read the second input number
	jal get_input
	#Stores the number from the user into $t1 register
	move $t1, $v0
	#Checking for the input if it will be greater than 255 at $t1 register
	jal check_input
	
	#Prompt for the operator	
	la $a0, enterOperator
	jal get_operator
	move $t2, $v0
	#Start the calculation
	jal start_calculating
	#Display the result
	jal display_result
	#Exit the Program
	jal exitProgram

get_input: 
	#Get input from the user
	#Print the prompt message
	li $v0, 4
	syscall
	#Read the integer input
	li $v0, 5
	syscall

	jr $ra
	
check_input:
	#Checks the integer value is within our range which is (0-255) and not greater than 255 if entered
	li $t3, 255
	bgt $t0, $t3, errorExceeds
	bgt $t1, $t3, errorExceeds
	jr $ra
	
get_operator:
	#Get input from user
	#Print the prompt message
	li $v0, 4
	syscall

	#Reads the character value
	li $v0, 12
	syscall
	move $t2, $v0
	
	jr $ra
	
start_calculating:
	#This will start the calculation whichever operator has been selected 
	#Reads which operator will be used based on the user input
	#ASCII TABLE in HEX:
	#Addition (+)= 0x2B; Subtraction (-) = 0x2D; Multiplication (*) = 0x2A; Division(/) = 0x2F
	#Additon 
	li $t3, 0x2B
	beq $t2, $t3, addition
	#Subtraction
	li $t3, 0x2D
	beq $t2, $t3, subtraction
	#Multiplication
	li $t3, 0x2A
	beq $t2, $t3, shiftingMethod_Multiplication
	#Division
	li $t3, 0x2F
	beq $t2, $t3, shiftingMethod_Division
	#Checks if we enter something else besides our four operators: (+), (-), (*), (/)
	
	j errorInvalidOperator
	
addition:
	#Add two numbers
	#Compute the sum and store in $t3 register
	add $t3, $t0, $t1	
	jr $ra
subtraction:
	blt $t0,$t1, errorUnsignedSubtraction
	#Subtract two numbers
	sub $t3, $t0, $t1
	jr $ra
#-------------------------------------------MULTIPLICATION SHIFTING METHOD----------------------------------------
shiftingMethod_Multiplication:
	move $t3, $zero
	li $t5, 8
shiftingMethodLoop_Multiplication:
	#If LSB of the multiplier is 1, then product = product + multiplicand
	#And immediate
	andi $t4, $t1, 1
	#If the LSB of the multiplier is 0, then do not perform addition
	#Branch if Equal to zero
	beqz $t4, shifting_Multiplication
	#Adding the multiplicand to the product due to the table example
	add $t3, $t3, $t0
	
shifting_Multiplication:
	#Shift left multiplicand by 1 shift
	sll $t0, $t0, 1
	#Shift right multiplier by 1 shift
	srl $t1, $t1, 1
	#Subtraction with immediate (Decrementation)
	subi $t5, $t5, 1
	#Branch if Not Equal to Zero
	bnez $t5, shiftingMethodLoop_Multiplication
	jr $ra
#-------------------------------------------DIVISION SHIFTING METHOD----------------------------------------
shiftingMethod_Division:
	#Checking if the input divisor is 0
	beq $t1, $zero, errorDivisionByZero
	#Dividend = 0; than so qoutient and remainder
	beq $t0, $zero, zero_Division	
	
	move $t4, $zero
	move $t3, $t0
shiftingMethodLoop_Division:
	#Checking if remainder is greater than divisor 
	blt $t3, $t1, shifting_Division
	#Subtract Divisor from remainder
	sub $t3, $t3, $t1
	#Incrementing the quotient
	addi $t4, $t4, 1
	#NonStop until remainder is greate than divisor
	j shiftingMethodLoop_Division
	
shifting_Division:
	jr $ra
	
zero_Division:
	#Remainder
	move $t3, $zero	
	#Quotient 
	move $t4, $zero
	j display_result

errorExceeds:
	#Printing the Error Exceeding prompt
	li $v0, 4
	la $a0, printErrorExceeds
	syscall
	#Exit the Program
	j exitProgram
	
errorInvalidOperator:
	#Printing the Invalid Operator prompt
	li $v0, 4
	la $a0, printInvalidOperator
	syscall
	#Exit the Program
	j exitProgram
	
errorDivisionByZero:
	#Printing the Division By Zero prompt
	li $v0, 4
	la $a0, printErrorDividedByZero
	syscall
	#Exit the Program
	j exitProgram

errorUnsignedSubtraction:
	#Printing the Unsigned Subtraction prompt
	li $v0, 4
	la $a0, printErrorUnsignedSubtraction
	syscall
	#Exit the Program
	j exitProgram

display_result:
	#Display the result
	li $v0, 4
	la $a0, printResult
	syscall
	#Display the remainder
	li $v0, 1
	move $a0, $t3
	syscall
	#Print a newLine
	li $v0, 4
	la $a0, printnewLine
	syscall
	
	li $t3, 0x2F
	beq $t2, $t3, display_div_result
	jr $ra
display_div_result:
	li $v0, 4
	la $a0, printQuotient
	syscall
	li $v0, 1
	move $a0, $t4
	syscall
	#Print a newLine
	li $v0, 4
	la $a0, printnewLine
	syscall
	jr $ra
exitProgram:
	#Exit the Program
	li $v0, 10
	syscall
	