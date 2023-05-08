.data
	opções: .asciiz "\n\nOPÇÃO1:Teste do palindromo\nOPÇÃO2:Quantidade de letras minúsculas e maiúsculas\nOPÇÃO3:Contagem do caracter escolhido\nOPÇÃO4:fecha o programa\n"
	insere_string: .asciiz "\nDigite uma string: "
	insere_caractere: .asciiz "\nDigite um caractere: "
	caracteres_iguais: .asciiz "Quantidade do caractere informado na string: "
	maiúscula: .asciiz "\nQuantidade de caracteres maiúsculos: "
	minúscula: .asciiz "\nQuantidade de caracteres minúsculos: "
	palavra_invertida: .word
	escolha: .asciiz
	.space 50
	falso: .asciiz "\nNão é palindromo"
	verdadeiro: .asciiz "\nÉ palindromo"
	
.text
menu:
	li $v0, 4
	la $a0, opções
	syscall
	
	li $v0, 5
	syscall
	
	beq $v0, 1, OPÇÃO1
	beq $v0, 2, OPÇÃO2
	beq $v0, 3, OPÇÃO3
	beq $v0, 4, FIM
	j menu
	
	OPÇÃO1:
		jal palindromo
		j menu
	OPÇÃO2:
		jal contagem_maiúscula_e_minúscula
		j menu
	OPÇÃO3:
		jal contagem_caractere_escolhido
		j menu
palindromo:					#--------------- Opção 1 ---------------
	
	li $v0, 4
	la $a0, insere_string
	syscall
	
	li $v0, 8
	la $a0, 0($sp)
	la $a1, 30
	syscall
	move $t0, $a0
	
	li $t1, 0	#contador tamanho
	la $a2, palavra_invertida
	
	loop_inverter_palavra:
		lb $t2, 0($t0)
		beq $t2, 10, cria_string_invertida
		addi $t1, $t1, 1
		addi $t0, $t0, 1
		
		j loop_inverter_palavra
	
	cria_string_invertida:
		addi $t0, $t0, -1
		addi $t1, $t1, -1
		lb $t2, 0($t0)
		sb $t2, 0($a2)
		addi $a2, $a2, 1
		bne $t1, $zero, cria_string_invertida
		
		la $a1, palavra_invertida
		move $t0, $a1
		move $t1, $a0
		
	testa_palindromo:
		lb $t2, ($t0)
		lb $t3, ($t1)
		beq $t3, 10, é_palindromo
		bne $t2, $t3, não_palindromo
		addi $t0, $t0, 1
		addi $t1, $t1, 1
		j testa_palindromo
	
	não_palindromo:
		li $v0, 4
		la $a0, falso
		syscall
		jr $ra
		
	é_palindromo:
		li $v0, 4
		la $a0, verdadeiro
		syscall
		jr $ra

contagem_maiúscula_e_minúscula:			#--------------- Opção 2 ---------------
	
	li $v0, 4
	la $a0, insere_string
	syscall

	li $v0, 8
	la $a0, 0($sp)
	li $a1, 30
	syscall
	move $t2, $a0
	
	li $t0, 0	#contador de letras maiúsculas
	li $t1, 0	#contador de letras minúsculas
	
	contagem_maiúscula:
		lb $t3, ($t2)
		beq $t3, 10, imprime
		blt $t3, 65, próxima
		bgt $t3, 90, contagem_minúscula
		addi $t0, $t0, 1	#se chegou aqui é maiúscula
		j próxima
	
	contagem_minúscula:
		blt $t3, 97, próxima
		bgt $t3, 122, próxima
		addi $t1, $t1, 1	#se chegou aqui é minúscula
		
	próxima:
		addi $t2, $t2, 1	#avança para o próximo caractere da string
		j contagem_maiúscula
		
	imprime:
		li $v0, 4
		la $a0, maiúscula
		syscall
		
		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0, minúscula
		syscall
		
		li $v0, 1
		move $a0, $t1
		syscall
		jr $ra
	
contagem_caractere_escolhido:			#-------------- Opção 3 ---------------

	li $v0, 4
	la $a0, insere_caractere
	syscall
	
	li $v0, 12
	syscall
	move $t1, $v0 	#endereço caractere
	
	li $v0, 4
	la $a0, insere_string
	syscall
	
	li $v0, 8
	la $a0, 0($sp)
	la $a1, 30
	syscall
	move $t2, $a0
	
	li $t0, 0	#contador
	
	inicio_contagem:
		lb $t3, ($t2)
		beq $t3, 10, printa
		bne $t3, $t1, próximo_caractere
		addi $t0, $t0, 1	#se chegou aqui é igual
	
	próximo_caractere:
		addi $t2, $t2, 1
		j inicio_contagem
		
	printa:
		li $v0, 4
		la $a0, caracteres_iguais
		syscall
		
		li $v0, 1
		move $a0, $t0
		syscall
		jr $ra
	
FIM:
