#szyfry
.data 
string_space: .space 1024
prompt3:	.asciiz "\nPodaj kod dzialania(S-szyfrowanie, D-deszyfrowanie) : "
prompt1:.asciiz "\nPodaj swój tekst : "
prompt2:.asciiz "\nPodaj klucz(OD 1 DO 25) : "
space:  .asciiz "\nZaszyfrowany kod : "
space2:  .asciiz "\nOdszyfrowany kod : "
pomoc: .word 26
.text
main:	
	#komunikat 1
	li $v0, 4
	la $a0, prompt1
	syscall
	#rezerwacja pamiêci
	la $a0,string_space
	li $a1, 51
	li $v0,8
	syscall
	
	#komunikat 2
	li $v0, 4
	la $a0, prompt2
	syscall
	li $v0, 5
	syscall
	move $t8,$v0

	#komunikat 3
	li $v0, 4
	la $a0, prompt3
	syscall
	li $v0, 12
	syscall
	move $t1,$v0
	
	beq $t1,'S',szyfrowanie
	beq $t1,'D',deszyfrowanie
	b exit
	
szyfrowanie:
	#koncowy komunikat
	la $a0,space
	li $v0,4
	syscall
	la $t2, string_space
szyfr_loop:
	lb $t3,($t2)
	beqz $t3,exit   #JEZELI KONIEC PRZERWIJ
	blt $t3,65,normal    #JEZELI NIE LITERA PRZESKOCZ(normalizacja)
	#szyfrowanie:
	add $t3,$t3,$t8
	subi $t3,$t3,65
	div $t3,$t3,26		#obliczanie ktora ma byc litera
	mfhi $t3
	addi $a0,$t3,65
	
	li $v0,11
	syscall
normal:	addu $t2,$t2,1
	b szyfr_loop


deszyfrowanie:
	#koncowy komunikat

	la $a0,space2
	li $v0,4
	syscall
	la $t2, string_space
	lw $t7,pomoc
	sub $t8,$t7,$t8
	b szyfr_loop

exit:
	li $v0,10
	syscall
