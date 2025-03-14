.data
	#Defines a string
	myMessage: .asciiz "ECE 422L -  Antonio Anzora Jr - Program B \n"
	enterNumberPrompt: .asciiz "Enter a number: "
	enterUnsignedPrompt: .asciiz "Product (Unsigned): "
	enterHexadecimalPrompt: .asciiz "Product (Hex): "
	enterBinaryPrompt: .asciiz "Product (Binary): "
	newline: .asciiz "\n"
	myInt: .word 5
.text

	li $v0, 4
	la $a0, enterNumberPrompt 
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, myInt
	lw $t0, myInt
				
	add $t1, $t1, $t0 #  t1 = t1 + val
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	
	li $v0, 4
	la $a0, enterUnsignedPrompt 
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
#------------------------------------------------------------------------
	li $v0, 4
	la $a0, enterHexadecimalPrompt 
	syscall
	
	li $v0, 34
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
#------------------------------------------------------------------------
	li $v0, 4
	la $a0, enterBinaryPrompt 
	syscall
	li $v0, 35
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	