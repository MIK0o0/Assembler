.data
NL: .asciiz "\n"

prompt2:.asciiz "\nAby kontynuowac podaj kolejna instrukcje, aby zakonczyc wcisnij 'E' \n"
data1: .asciiz "ADD"
data2: .asciiz "ADDI"
data3: .asciiz "J"
data4: .asciiz "NOOP"
data5: .asciiz "MULT"
data6: .asciiz "JR"
data7: .asciiz "JAL"
test: .asciiz "NOOP"
#array
array: .word data1,data2,data3,data4,data5,data6,data7
size: .word 7
.text 
	la $t1,array
	lw $t2, size
	li $t3, 0
	#test
	la $t4,test
loop:
	beq $t2,$t3,exit
	lw $t5,($t1)
	move $a0,$t5
	li $v0,4
	syscall
	
	addi $t1,$t1,4
	addi $t3,$t3,1
	j loop

exit:
	li $v0,10
	syscall