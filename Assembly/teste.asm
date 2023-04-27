.data
	OPCAO1: .asciiz "\n\nOPCÂO 1:\n"				#Lê uma string e informa se é um palindromo ou não
	OPCAO2: .asciiz "OPCÂO 2:\n"					#Lê uma string e informa a quantidade de caracteres maiúsculos e minúsculos
	OPCAO3: .asciiz "OPCÂO 3:\n"					#Lê uma string e um caractere e informa quantos do caractere escolhido existem na string informada
	insira_string: .asciiz "\nDigite uma string: "
	insira_caractere: .asciiz "Digite um caractere: "
	maiuscula: .asciiz "Quantidade de letras maiúsculas: "
	minuscula: .asciiz "\nQuantidade de letras minúsculas: "
	contagem_igual: .asciiz "\nQuantidade do caractere informado na string: "
	SAIR: .asciiz "OPCÂO 4(SAIR DO PROGRAMA):\n"
	escolha: .asciiz
	espaco: .space 30
	
.text

menuloop:
	li $v0, 4
	la $a0, OPCAO1
	syscall
	li $v0, 4
	la $a0, OPCAO2
	syscall
	li $v0, 4
	la $a0, OPCAO3
	syscall
	li $v0, 4
	la $a0, SAIR
	syscall
	li $v0, 5
	la $a1, 30
	la $a0, escolha
	syscall
	beq $v0, 1, Palindromo
	beq $v0, 2, Quantidade_de_caracteres
	beq $v0, 3, Contagem_caracter_escolhido
	beq $v0, 4, FIM
	
Palindromo:      					 #--------------OPCÃO 1--------------------
	
	
	
	
	
	j menuloop
	
	
	
Quantidade_de_caracteres:				#--------------OPCÃO 2--------------------
	li $v0, 4
	la $a0, insira_string
	syscall
	
	#Lê a string inserida pelo usuário
	li $v0, 8
	la $a0, 0($sp)
	li $a1, 30
	syscall
	
	li $t0, 0 	#contador de letras maiúsculas
	li $t1, 0	#contador de letras minúsculas
	move $t2, $a0	#endereço da string
		
	contagem_minúscula:
		lb $t3, ($t2)
		beq $t3, 10, imprime
		blt $t3, 97, contagem_maiúscula
		bgt $t3, 122, contagem_maiúscula
		addi $t1, $t1, 1 	#se chegou aqui, então é minúscula
		j proxima
		
	contagem_maiúscula:
		blt $t3, 65, proxima
		bgt $t3, 90, proxima
		addi $t0, $t0, 1	#se chegou aqui, então é maiúscula
	
	proxima:
		addi $t2, $t2, 1	#avança para o próximo caractere
		j contagem_minúscula
	
	imprime:
		li $v0, 4
		la $a0, maiuscula
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0, minuscula
		syscall
		li $v0, 1
		move $a0, $t1
		syscall
		j menuloop	
		
		
		
Contagem_caracter_escolhido:				#--------------OPCÃO 3--------------------

	li $v0, 4
	la $a0, insira_caractere
	syscall
	
#Lê o caractere inserido pelo usuário
	li $v0, 12
	syscall
	move $t1, $v0 	#endereço caractere
	
	li $v0, 4
	la $a0, insira_string
	syscall
	
#Lê a string inserida pelo usuário
	li $v0, 8
	la $a0, 0($sp)
	li $a1, 30
	syscall
	move $t2, $a0	#endereço da string

	li $t0, 0	#contador
	
	contagem:
		lb $t3, ($t2)
		beq $t3, 10, imprime2
		beq $t3, $t1, igual
		addi $t2, $t2, 1
		j contagem
	
	igual:
		addi $t0, $t0, 1
		addi $t2, $t2, 1
		j contagem
	
	imprime2:
		li $v0, 4
		la $a0, contagem_igual
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		j menuloop
			
		
		
FIM:
	li $v0,10
	syscall 
