#kalkulator
	.data 
dodawanie: .word 1
prompt:	.asciiz "\nPodaj kod dzialania oraz trzy liczby : "
prompt2:.asciiz "\nCzy chesz kontynuowac?"
prompt3:.asciiz "\nPodaj liczbe b :"
prompt4:.asciiz "\nPodaj liczbe c :"
prompt5:.asciiz "\nPodaj liczbe d :"
prompt6:.asciiz "\nWynik dzialania :"

.text
main:	#wy�wietl komunikat pierwszy
	li $v0,4
	la $a0,prompt
	syscall 
	#wczytaj kod dzia�ania
	li $v0,5
	syscall
	move $t0,$v0 
	
	#wy�wietl komunikat 3
	li $v0,4
	la $a0,prompt3
	syscall 
	#wczytaj pierwsz� liczb�
	li $v0,5
	syscall
	move $t1,$v0
	
	#wy�wietl komunikat 4
	li $v0,4
	la $a0,prompt4
	syscall 
	#wczytaj drug� liczb�
	li $v0,5
	syscall
	move $t2,$v0
	
	#wy�wietl komunikat 5
	li $v0,4
	la $a0,prompt5
	syscall 
	#wczytaj trzeci� liczb�
	li $v0,5
	syscall
	move $t3,$v0
	
	#warunek wboru dzia�ania
	
	beq $t0,1,pierwszy
	beq $t0,2,drugi
	beq $t0,3,trzeci

Fin:
	#wydrukuj wynik
	#li $v0,4
	#la $a0,prompt6
	#syscall 
	move $a0,$t7
	li $v0,1
	syscall
	#wy�wietl komunikat 2
	li $v0,4
	la $a0,prompt2
	syscall 
	#wczytaj czy chce kontynuowa�
	li $v0,5
	syscall
	move $t5,$v0 
	
	#warunek na kontynuowanie
	beq $t5,1,main
	#end
	li $v0,10
	syscall
	
	#dzia�ania:
pierwszy: add $t1,$t1,$t2
	mul $t7,$t1,$t3
	b Fin
drugi: sub $t1,$t1,$t2
	div $t7,$t1,$t3
	b Fin
trzeci: sub $t1,$t1,$t2
	add $t7,$t1,$t3
	b Fin