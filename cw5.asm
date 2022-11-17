.data
 errorNumber: .asciiz "\nWprowadziles niepoprawne znaki. Sprobuj ponownie:"
 roundsNumberPrompt: .asciiz "\nIle chcesz, aby trwala rozgrywka? (1 - 5 rund): "
 xOrO: .asciiz "\nJakim znakiem chcesz grac? (X lub O): "
 newline: .asciiz "\n"
 makeNewCheck: .asciiz "\nGdzie chesz postawic swoj znak: "
 currentState: .asciiz "\nStan gry: \n"
 computerWin: .asciiz "\nKomputer wygral!\n"
 playerWin: .asciiz "\nWygrales!\n"
 creatingNewArray: .asciiz "\n"
 array: .space 36
 resultArray: .space 20
 resultsPlayer: .asciiz "\nRundy wygrane przez gracza: "
 resultsComputer: .asciiz "\nRundy wygrane przez komputer: "
 endOfRound: .asciiz "\nKoniec rundy!\n"
 
 .text
 # $s0 - liczba rund
 # $s1 - znak gracza
 # $s2 - znak komputera
 # $s3 - znak '-' 
 # $s4 - 3 razy znak gracza
 # $s5 - 3 razy znak kom
 # $s6 - rundy gracza
 # $s7 - rundy komputera

  li $s3, 45
  li $s6, 0
  li $s7, 0

  
 
 # $t0 - numer obecnego znaku
 # $t1 - znak tego co wykonuje ruch
 # $t2 - licznik zajetych kafelkow


 main:
 #ile rund
 loadRounds:
 la $a0, roundsNumberPrompt
 li $v0, 4
 syscall
 li $v0, 12
 syscall

 la $s0, ($v0)
 ble $s0, 48, wrongNumber
 bge $s0, 54, wrongNumber
 addi $s0, $s0, -48
 
 
 
 
 # znak gracza
 loadUserSign:
 la $a0, xOrO
 li $v0, 4
 syscall
 li $v0, 12
 syscall
 la $s1, ($v0)
 #kontrola znaku X or O
 beq $s1, 79, initO
 beq $s1, 88, initX
 j wrongSign
 
 
 

 initX:
 li $s2, 79
 li $s4, 264
 li $s5, 237
 j init

 initO:
 li $s2, 88
 li $s4, 237
 li $s5, 264
 
  #tworzenie tabeli 
 init:
 li $t2, 0
 la $a0, creatingNewArray
 li $v0, 4
 syscall
 addi $t0, $zero, 0
 
 #wype³nienie tablicy "-"
 initLoop:
 sb $s3, array($t0)
 addi $t0, $t0, 4
 bne $t0, 36, initLoop
 addi $t0, $t0, -36

 
 loop:
 usersInput:
  la $t1, ($s1)
 #gdzie chce ruszyæ
  la $a0, makeNewCheck
  li $v0, 4
  syscall

  li $v0, 12
  syscall
  
  blt $v0, 49, wrongField
  bgt $v0, 57, wrongField
  beq $v0, 49, playerInput49
  beq $v0, 50, playerInput50
  beq $v0, 51, playerInput51
  beq $v0, 52, playerInput52
  beq $v0, 53, playerInput53
  beq $v0, 54, playerInput54
  beq $v0, 55, playerInput55
  beq $v0, 56, playerInput56
  beq $v0, 57, playerInput57
  
  #po sprawdzeniu
  userCheckEnd:


 #wprowadzenie znaku i sprawdzenie czy ktos nie wygral
 jal loopExec
 
 #ruch komputera:
 computerInput:
 
 beq $t2, 9, end
 # wczytanie znaku komputera
 la  $t1, ($s2)
 j computerInputCheck

 computerCheckEnd:
 jal loopExec
 

  end:
 #beqz $s0, init
 bne $t2, 9, loop
 addi $s0, $s0, -1
 #ostatni komunikat
 la $a0, endOfRound
 li $v0, 4
 syscall
 bnez $s0, init
 #wynik gracza
  la $a0, resultsPlayer
 li $v0, 4
 syscall
 la $a0, ($s6)
 li $v0, 1
 syscall
 #wynik komputera
 la $a0, resultsComputer
 li $v0, 4
 syscall
 la $a0, ($s7)
 li $v0, 1
 syscall
 #exit
 li $v0, 10
 syscall
 
 
 
 
 
 
 #funkcje sprawdzajace czy mozna wpisac znak 
 playerInput49:
 addi $t0, $zero, 0
 lb $t7, array($t0)
 bne $t7, 45, wrongField
 j userCheckEnd
 
 playerInput50:
  addi $t0, $zero, 4
  lb $t7, array($t0)
 bne $t7, 45, wrongField
 j userCheckEnd
 
 playerInput51:
  addi $t0, $zero, 8
  lb $t7, array($t0)
 bne $t7, 45, wrongField
 j userCheckEnd
 
 playerInput52:
  addi $t0, $zero, 12
  lb $t7, array($t0)
 bne $t7, 45, wrongField
 j userCheckEnd
 
 playerInput53:
  addi $t0, $zero, 16
  lb $t7, array($t0)
 bne $t7, 45, wrongField
 j userCheckEnd
 
 playerInput54:
  addi $t0, $zero, 20
  lb $t7, array($t0)
 bne $t7, 45, wrongField
 j userCheckEnd
 
 playerInput55:
  addi $t0, $zero, 24
  lb $t7, array($t0)
 bne $t7, 45, wrongField
 j userCheckEnd
 
 playerInput56:
  addi $t0, $zero, 28
  lb $t7, array($t0)
 bne $t7, 45, wrongField
 j userCheckEnd
 
 playerInput57:
  addi $t0, $zero, 32
  lb $t7, array($t0)
 bne $t7, 45, wrongField
 j userCheckEnd
 
 

 computerInputCheck:
 
  computerInput53:
 addi $t0, $zero, 16
 lb $t7, array($t0)
 beq $t7, 45, computerCheckEnd
 
 computerInput49:
 addi $t0, $zero, 24
 lb $t7, array($t0)
 beq $t7, 45, computerCheckEnd
 
   computerInput57:
 addi $t0, $zero, 32
 lb $t7, array($t0)
 beq $t7, 45, computerCheckEnd

  computerInput50:
 addi $t0, $zero, 0
 lb $t7, array($t0)
 beq $t7, 45, computerCheckEnd
 
   computerInput51:
 addi $t0, $zero, 8
 lb $t7, array($t0)
 beq $t7, 45, computerCheckEnd
 
    computerInput55:
 addi $t0, $zero, 4
 lb $t7, array($t0)
 beq $t7, 45, computerCheckEnd
 
    computerInput56:
 addi $t0, $zero, 12
 lb $t7, array($t0)
 beq $t7, 45, computerCheckEnd
 
     computerInput52:
 addi $t0, $zero, 28
 lb $t7, array($t0)
 beq $t7, 45, computerCheckEnd
 
     computerInput54:
 addi $t0, $zero, 20
 lb $t7, array($t0)
 beq $t7, 45, computerCheckEnd
 j end
 
 
 loopExec:
 signing:
 #wpisanie znaku
 sb $t1, array($t0)
 
 addi $t2, $t2, 1
 
 winChecking:
 #sprawdzanie czy ktos wygral
 #przekatna 1,5,9
 addi $t0, $zero, 0
 lb $t3, array($t0)
  addi $t0, $t0, 16
 lb $t4, array($t0)
   addi $t0, $t0, 16
 lb $t5, array($t0)

 add $t6, $t3, $t4
 add $t6, $t6, $t5
 beq $t6, $s4, playerWon
 beq $t6, $s5, computerWon


  #przekatna 3,5,7
  addi $t0, $zero, 8
 lb $t3, array($t0)
 
   addi $t0, $zero, 24
 lb $t5, array($t0)

 add $t6, $t3, $t4
 add $t6, $t6, $t5
 beq $t6, $s4, playerWon
 beq $t6, $s5, computerWon
 

 addi $t0, $zero, 12
 lb $t3, array($t0)

   addi $t0, $zero, 20
 lb $t5, array($t0)

 add $t6, $t3, $t4
 add $t6, $t6, $t5
 beq $t6, $s4, playerWon
 beq $t6, $s5, computerWon
 
 
   #
  addi $t0, $zero, 4
 lb $t3, array($t0)

   addi $t0, $zero, 28
 lb $t5, array($t0)
   
 add $t6, $t3, $t4
 add $t6, $t6, $t5
 beq $t6, $s4, playerWon
 beq $t6, $s5, computerWon
 
 
 #
  addi $t0, $zero, 0
 lb $t3, array($t0)
  addi $t0, $zero, 12
 lb $t4, array($t0)
   addi $t0, $zero, 24
 lb $t5, array($t0)

 add $t6, $t3, $t4
 add $t6, $t6, $t5
 beq $t6, $s4, playerWon
 beq $t6, $s5, computerWon
 
 
    #
  addi $t0, $zero, 4
 lb $t4, array($t0)
   addi $t0, $zero, 8
 lb $t5, array($t0)
   
 add $t6, $t3, $t4
 add $t6, $t6, $t5
 beq $t6, $s4, playerWon
 beq $t6, $s5, computerWon
 
  #
  addi $t0, $zero, 8
 lb $t3, array($t0)
  addi $t0, $zero, 20
 lb $t4, array($t0)
   addi $t0, $zero, 32
 lb $t5, array($t0)
  
 add $t6, $t3, $t4
 add $t6, $t6, $t5
 beq $t6, $s4, playerWon
 beq $t6, $s5, computerWon
 
    #
  addi $t0, $zero, 24
 lb $t3, array($t0)
  addi $t0, $zero, 28
 lb $t4, array($t0)

 add $t6, $t3, $t4
 add $t6, $t6, $t5
 beq $t6, $s4, playerWon
 beq $t6, $s5, computerWon
 
 
 
 statePrinting:
 #obecny stan
 la $a0, currentState
 li $v0, 4
 syscall
 
 # $t0 - reset do zera
 addi $t0, $zero, 0
 
 #1 rzad
 la $a0, array($t0)
 li $v0, 4
 syscall
 
 addi $t0, $t0, 4
 la $a0, array($t0)
 li $v0, 4
 syscall
 
 addi $t0, $t0, 4
 la $a0, array($t0)
 li $v0, 4
 syscall
 
 #nl
 la $a0, newline
 li $v0, 4
 syscall
 
  #2 rzad
 addi $t0, $t0, 4
 la $a0, array($t0)
 li $v0, 4
 syscall
 
 addi $t0, $t0, 4
 la $a0, array($t0)
 li $v0, 4
 syscall
 
 addi $t0, $t0, 4
 la $a0, array($t0)
 li $v0, 4
 syscall
 
  #nl
  la $a0, newline
 li $v0, 4
 syscall
 
  #3 rzad
 addi $t0, $t0, 4
 la $a0, array($t0)
 li $v0, 4
 syscall
 
 addi $t0, $t0, 4
 la $a0, array($t0)
 li $v0, 4
 syscall
 
 addi $t0, $t0, 4
 la $a0, array($t0)
 li $v0, 4
 syscall
 
  #nl
  la $a0, newline
 li $v0, 4
 syscall
 

 addi $t0, $t0, -32
 
 
 jr $ra
 

 
 
 
 
 
 
 #zakonczenia:
 
 playerWon:
 la $a0, playerWin
 li $v0, 4
 syscall

 addi $s6, $s6, 1

 li $t2, 9
 jal statePrinting
 j end
 
 computerWon:
  la $a0, computerWin
 li $v0, 4
 syscall
 
 addi $s7, $s7, 1

 li $t2, 9
 jal statePrinting
 j end
 
 
 
 
 
 
 
 
 
 #bledy
 
 wrongNumber:
 la $a0, errorNumber
 li $v0, 4
 syscall
 j loadRounds
 
 
 wrongSign:
 la $a0, errorNumber
 li $v0, 4
 syscall
 j loadUserSign
 
 
  wrongField:
 la $a0, errorNumber
 li $v0, 4
 syscall
 j usersInput
