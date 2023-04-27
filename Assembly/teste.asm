.data
	OPCAO1: .asciiz "\n\nOPC�O 1:\n"
	OPCAO2: .asciiz "OPC�O 2:\n"
	OPCAO3: .asciiz "OPC�O 3:\n"
	insira: .asciiz "Digite uma string: "
	maiuscula: .asciiz "Quantidade de letras mai�sculas: "
	minuscula: .asciiz "\nQuantidade de letras min�sculas: "
	new_line: .asciiz "\n"
	SAIR: .asciiz "OPC�O 4(SAIR DO PROGRAMA):\n"
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
	
Palindromo:       #--------------OPC�O 1--------------------
	
	j menuloop
Quantidade_de_caracteres:	#--------------OPC�O 2--------------------
	li $v0, 4
	la $a0, insira
	syscall
	
	#L� a string inserida pelo usu�rio
	li $v0, 8
	la $a0, 0($sp)
	li $a1, 30
	syscall
	
	li $t0, 0 	#contador de letras mai�sculas
	li $t1, 0	#contador de letras min�sculas
	move $t2, $a0	#endere�o da string
		
	contagem_min�scula:
		lb $t3, ($t2)
		beq $t3, 10, imprime
		blt $t3, 97, contagem_mai�scula
		bgt $t3, 122, contagem_mai�scula
		addi $t1, $t1, 1 	#se chegou aqui, ent�o � min�scula
		j proxima
		
	contagem_mai�scula:
		blt $t3, 65, proxima
		bgt $t3, 90, proxima
		addi $t0, $t0, 1	#se chegou aqui, ent�o � mai�scula
	
	proxima:
		addi $t2, $t2, 1	#avan�a para o pr�ximo caractere
		j contagem_min�scula
	
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
Contagem_caracter_escolhido:	#--------------OPC�O 3--------------------
	
	j menuloop
FIM:
	li $v0,10
	syscall 
