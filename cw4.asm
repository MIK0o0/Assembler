.data
prompt1: .asciiz "\nWybierz operacje:\n1.Dodawanie\n2.Odejmowanie\n3.Mnozenie\n4.Dzielenie\n"
prompt2: .asciiz "\nUzyles niepoprawnego znaku!! Sprobuj ponownie\n"
prompt3: .asciiz "\nUzyles pzecinka, zamiast kropki!! Sprobuj ponownie\n"
prompt4: .asciiz "\nWprowadzi³es za duza liczbe!! Sprobuj ponownie\n"
prompt5: .asciiz "\nPodaj pierwsza liczbe: \n"
prompt6: .asciiz "\nPodaj druga liczbe: \n"
prompt7: .asciiz "\nDzielenie przez zero!!! \n"
prompt8: .asciiz "\nTwoj wynik to:  \n"
prompt9: .asciiz "\nChcesz kontynuowac, wcisinij 1, jesli nie to wcisnij cokolwiek  \n"
nl: 	.asciiz "\n"
float: 	.double 10.0
zero0: 	.double 0.0
double1: .double 1.0
string: .space 1024
.text
main: 	la $a0,prompt1
	li $v0, 4
	syscall
	#$t9 - wybor
	#$t8 - pierwszy czy drugi
	#$s7 - czy minus
	
	li $v0,5
	syscall
	move $t9,$v0
	blt $t9,1,main
	bgt $t9,4,main
wybor:	
	beqz $t8,pierwsza
	la $a0,prompt6
	li $v0, 4
	syscall
	j wprowadzenie
pierwsza:
	la $a0,prompt5
	li $v0, 4
	syscall
	
wprowadzenie:	
	la $a0,string
	li $a1,35
	li $v0, 8
	syscall
	
	la $t3, string
	li $s0,-1 
	li $s1,0
	li $t4,0 #flaga czy by³a kropka
	lb $t1,($t3)
	beq $t1,45,minus
	
check:	
	lb $t1,($t3)
	blt $t1,43,dl_check
	beq $t1,44,przecinek
	
	bgt $t1,58,error
	#blt $t1,45,error
	
	beq $t1,46,kropka
krop_pow:	
	addi $t3,$t3,1
	beqz $t4,przed
	addi $s1,$s1,1
	j check
	
przed:	
	addi $s0,$s0,1
	j check

kropka:
	addi $t4,$t4,1
	j krop_pow
minus:
	addi $s7,$s7,1
	addi $t3,$t3,1
	j check
error:
	la $a0,prompt2
	li $v0,4
	syscall
	j wybor
przecinek:
	la $a0,prompt3
	li $v0,4
	syscall
	j wybor	

dl_check:
	add $s6,$s0,$s1
	blt $s6,52,good
	la $a0,prompt4
	li $v0,4
	syscall
	j main

good:

	la $t3, string
	add $t3,$t3,$s0
	li $t6,1
	la $t4,string
	add $t4,$t4,$s0
	addi $t4,$t4,2
	l.d $f8,double1
	l.d $f10,float
	l.d $f18,zero0
	mul.d $f4,$f4,$f18
	
	#sub $s0,$s0,$s7
	add $t3,$t3,$s7
	add $t4,$t4,$s7
	#$f4 #nasza liczba
wczytCal_loop:	#3wczytaj ca³kowita czesc
	lb $t1,($t3)
	subi $t1,$t1,48
	
	mtc1.d $t1, $f6
	cvt.d.w $f6,$f6
	
	mul.d $f6,$f6,$f8
	
	add.d $f4,$f4,$f6
	
	
	mul.d $f8,$f8,$f10
	addi $t3,$t3,-1
	beqz $s0,reset 	#zmien
	subi $s0,$s0,1
	
	j wczytCal_loop	
reset:
	l.d $f8,float
	l.d $f10,float
	l.d $f18,zero0
wczytajDzie_loop:

	lb $t1,($t4)
	subi $t1,$t1,48
	bltz $t1,zapisz 	#tj
	
	
	mtc1.d $t1, $f6
	cvt.d.w $f6,$f6
	div.d $f6,$f6,$f8
	
	add.d $f4,$f4,$f6
	
	mul.d $f8,$f8,$f10
	addi $t4,$t4,1
	
	subi $s1,$s1,1
	j wczytajDzie_loop
zapisz:
	beqz $s7,nie_neg
	neg.d $f4,$f4
	
nie_neg:
	#f16 - pierwsza
	#f4 - druga
	
	mul $s7,$s7,$zero
	beqz $t8,zap_pierwsza
	j po_zapis
zap_pierwsza:
	mov.d $f16,$f4
	mtc1.d $zero,$f4
	cvt.d.w $f4,$f4
	addi $t8,$t8,1
	j wybor
po_zapis:
	beq $t9,1,jeden
	beq $t9,2,dwa
	beq $t9,3,trzy
	beq $t9,4,cztery
	
jeden:
	add.d $f16,$f16,$f4
	j wynik
dwa:
	sub.d $f16,$f16,$f4
	j wynik
trzy:
	mul.d $f16,$f16,$f4
	j wynik
cztery:	
	div.d $f16,$f16,$f4
	cvt.w.d $f4,$f4
	mfc1.d $s4,$f4
	beqz $s4,zero
	j wynik
zero:
	la $a0,prompt7
	li $v0, 4
	syscall
	j kontynuuj
wynik:
	la $a0,prompt8
	li $v0, 4
	syscall
	
	mov.d $f12,$f16
	li $v0,3
	syscall
	jal NL
	
kontynuuj:
	la $a0,prompt9
	li $v0, 4
	syscall	
	
	mul $t8,$t8,$zero
	
	li $v0,5
	syscall
	beq $v0,1,main
	j exit
	
exit:	
	li $v0,10
	syscall


NL:
	la $a0,nl
	li $v0,4
	syscall
	jr $ra

	mov.d $f12,$f6
	move $a0,$t5
	li $v0,3
	syscall
	jal NL





