.data 
	myMessage: .asciiz "Hello World\n"

.text 
	li $v0, 4	#Print
	la $a0, myMessage #string address
	syscall #execution
