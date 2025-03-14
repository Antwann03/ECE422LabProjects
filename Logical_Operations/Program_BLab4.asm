.data
    myNameMessage: .asciiz "ECE 422L - Antonio Anzora Jr - Program B\n"
    EnterInt: .asciiz "Enter an integer: "
    EnterBitPos: .asciiz "Enter the bit position (0 - 31): "
    myMessageInt: .asciiz "Integer (Binary): "
    myMessageBitPos: .asciiz "Bit Position: "
    myBitMask: .asciiz "Bit Mask: "
    myInvertedBitMask: .asciiz "Inverted Bit Mask: "
    mySetResult: .asciiz "Set Result: "
    myClearResult: .asciiz "Clear Result: "
    myToggleResult: .asciiz "Toggle Result: "
    newLine: .asciiz "\n"
    #Initializing the Array
    #myArray: .word 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    #Definining the size of the array
    #arrayLength: .word 32
	
.text
    #Display name and course name
    li $v0, 4
    la $a0, myNameMessage
    syscall
    
    #Prompt for the integer
    li $v0, 4
    la $a0, EnterInt
    syscall
    
    #Read the integer and store it in $t0
    li $v0, 5
    syscall
    move $t0, $v0
    
    #Prompt for the bit position
    li $v0, 4
    la $a0, EnterBitPos
    syscall
    
    #Read the bit position and store it in $t1
    li $v0, 5
    syscall
    move $t1, $v0
    
    #Display the Integer in Binary
    li $v0, 4
    la $a0, myMessageInt
    syscall
    
    #Print the integer in binary
    li $v0, 35
    move $a0, $t0
    syscall
    
    #Display a new line
    li $v0, 4
    la $a0, newLine
    syscall
    
    #Display the Bit Position
    li $v0, 4
    la $a0, myMessageBitPos
    syscall
    #Print the bit position in decimal
    li $v0, 1
    move $a0, $t1
    syscall
    
    # Display a new line
    li $v0, 4
    la $a0, newLine
    syscall

    #Generate the Bit Mask: Shift 1 left by bit position (1 << bit_position)
    #Load 1 into $t2
    li $t2, 1
    #Shift 1 left by the value in $t1 (bit position)
    sllv $t2, $t2, $t1
    
    # Display the Bit Mask
    li $v0, 4
    la $a0, myBitMask
    syscall
    #Print the Bit Mask in binary
    li $v0, 35
    move $a0, $t2
    syscall
    
    #Display a new line
    li $v0, 4
    la $a0, newLine
    syscall
    
    #Generate the Inverted Bit Mask: NOT the Bit Mask
    nor $t3, $t2, $zero     
    
    # Display the Inverted Bit Mask
    li $v0, 4
    la $a0, myInvertedBitMask
    syscall
    #Print the Inverted Bit Mask in binary
    li $v0, 35
    move $a0, $t3
    syscall
    
    #Display a new line
    li $v0, 4
    la $a0, newLine
    syscall
    
    #Set the bit at position: Integer OR Bit Mask
    #Set the bit by OR'ing with the Bit Mask
    or $t4, $t0, $t2   
    
    #Display the Set Result
    li $v0, 4
    la $a0, mySetResult
    syscall
    #Print the Set Result in binary
    li $v0, 35
    move $a0, $t4
    syscall
    
    #Display a new line
    li $v0, 4
    la $a0, newLine
    syscall
    
    # Clear the bit at position: Integer AND Inverted Bit Mask
    and $t5, $t0, $t3  # Clear the bit by AND'ing with the Inverted Bit Mask
    
    #Display the Clear Result
    li $v0, 4
    la $a0, myClearResult
    syscall
    #Print the Clear Result in binary
    li $v0, 35
    move $a0, $t5
    syscall
    
    #Display a new line
    li $v0, 4
    la $a0, newLine
    syscall
    
    #Toggle the bit at position: Integer XOR Bit Mask
    #Toggle the bit by XOR'ing with the Bit Mask
    xor $t6, $t0, $t2  
    
    #Display the Toggle Result
    li $v0, 4
    la $a0, myToggleResult
    syscall
    
    #Print the Toggle Result in binary
    li $v0, 35
    move $a0, $t6
    syscall
    
    #Display a new line
    li $v0, 4
    la $a0, newLine
    syscall
    
    # Exit the program
    li $v0, 10
    syscall
