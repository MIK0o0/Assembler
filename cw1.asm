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
main:	#wyœwietl komunikat pierwszy
	li $v0,4
	la $a0,prompt
	syscall 
	#wczytaj kod dzia³ania
	li $v0,5
	syscall
	move $t0,$v0 
	
	#wyœwietl komunikat 3
	li $v0,4
	la $a0,prompt3
	syscall 
	#wczytaj pierwsz¹ liczbê
	li $v0,5
	syscall
	move $t1,$v0
	
	#wyœwietl komunikat 4
	li $v0,4
	la $a0,prompt4
	syscall 
	#wczytaj drug¹ liczbê
	li $v0,5
	syscall
	move $t2,$v0
	
	#wyœwietl komunikat 5
	li $v0,4
	la $a0,prompt5
	syscall 
	#wczytaj trzeci¹ liczbê
	li $v0,5
	syscall
	move $t3,$v0
	
	#warunek wboru dzia³ania
	
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
	#wyœwietl komunikat 2
	li $v0,4
	la $a0,prompt2
	syscall 
	#wczytaj czy chce kontynuowaæ
	li $v0,5
	syscall
	move $t5,$v0 
	
	#warunek na kontynuowanie
	beq $t5,1,main
	#end
	li $v0,10
	syscall
	
	#dzia³ania:
pierwszy: add $t1,$t1,$t2
	mul $t7,$t1,$t3
	b Fin
drugi: sub $t1,$t1,$t2
	div $t7,$t1,$t3
	b Fin
trzeci: sub $t1,$t1,$t2
	add $t7,$t1,$t3
	b Fin