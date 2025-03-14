.data
	myNameMessage: .asciiz "ECE 422L - Antonio Anzora Jr - Multiplication Algorithm\n"
	EnterMultiplicandMessage: .asciiz "Enter the multiplicand (0-255):"
	EnterMultiplierMessage: .asciiz "Enter the multiplier (0-255):"
	printMultiplicand: .asciiz "Multiplicand: "
	printMultiplier: .asciiz "Multiplier: "
	printProductMessage: .asciiz "The product is: "
	newLine: .asciiz "\n"
	printErrorMessage: .asciiz " Error! One of the values exceeds 8 bits."
.text
	#Display Course Name, Project Name and My Name
	li $v0, 4
	la $a0, myNameMessage	
	syscall
	
	#Display  the Prompt Multiplicand Message
	li $v0, 4
	la $a0, EnterMultiplicandMessage
	syscall
	#Reading the integer and storing the value into $t0 register
	li $v0, 5
	syscall
	move $t0, $v0
	
	#Display the Prompt Multiplier Message
	li $v0, 4
	la $a0, EnterMultiplierMessage
	syscall
	#Reading the integer and storing the value into $t1 register
	li $v0, 5
	syscall
	move $t1, $v0

	#Display the Multiplicand Message with the entered value
	li $v0, 4
	la $a0, printMultiplicand
	syscall
	#Print the multiplicand value in decimal 
	li $v0, 1
	move $a0, $t0
	syscall
	#Display a newLine
	li $v0, 4
	la $a0, newLine
	syscall
	
	#Display the Multplier Message with the entered value
	li $v0, 4
	la $a0, printMultiplier
	syscall
	#Print the multiplier value in decimal
	li $v0, 1
	move $a0, $t1
	syscall
	#Display anewLine
	li $v0, 4
	la $a0, newLine
	syscall

	#Checking if the user enters a value greater than 255
	li $t2, 255
	#Branch if Greater Than = bgt
	#Checking if mutliplicand will be greater than 255, if so jump to error message 
	bgt $t0, $t2, errorMessageProgram
	#Checking if mutliplier will be greater than 255, if so jump to error message 
	bgt $t1, $t2, errorMessageProgram
	#Checking if the user enters a value of zero and then it will exit the program for the multiplicand
	beq $t0, $zero, exitZeroProgram
	#Checking if user enters zero so that it can print but will exit the program for the multiplier
	beq $t1, $zero, exitZeroProgram
	#Resettting the product value	
	move $t2, $zero
	#8 bits shifting
	li $t3, 8
	
shiftAddingMethod:
	#If LSB of the multiplier is 1, then product = product + multiplicand
	#And immediate
	andi $t4, $t1, 1
	#If the LSB of the multiplier is 0, then do not perform addition
	#Branch if Equal to zero
	beqz $t4, stepProgram
	#Adding the multiplicand to the product due to the table example
	add $t2, $t2, $t0

stepProgram:
	#Shift left multiplicand by 1 shift
	sll $t0, $t0, 1
	#Shift right multiplier by 1 shift
	srl $t1, $t1, 1
	#Subtraction with immediate (Decrementation)
	subi $t3, $t3, 1
	#Branch if Not Equal to Zero
	bnez $t3, shiftAddingMethod
	
	#Print the product
	li $v0, 4
	la $a0, printProductMessage
	syscall
	move $a0, $t2
	li $v0, 1
	syscall
	#Exit the Program
	li $v0, 10
	syscall
	
errorMessageProgram:
	#Printing the Error Message if the user inputs a greater value than 255
	li $v0, 4
	la $a0, printErrorMessage
	syscall
	#Exit the Program of ErrorMessageProgram
	li $v0, 10
	syscall
exitZeroProgram:
	li $v0, 4
	la $a0, printProductMessage
	syscall
	#Load immediat for printing an integer 
	li $v0, 1
	#Load immediate value 0 into $a0: we want to print 0, we load/store 0 into $a0 register
	li $a0, 0
	syscall
	#Prints the newLine
	li $v0, 4
	la $a0, newLine
	syscall
	#Exit the Program
	li $v0, 10
	syscall
	