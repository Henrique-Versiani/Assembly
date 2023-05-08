.data
	op��es: .asciiz "\n\nOP��O1:Teste do palindromo\nOP��O2:Quantidade de letras min�sculas e mai�sculas\nOP��O3:Contagem do caracter escolhido\nOP��O4:fecha o programa\n"
	insere_string: .asciiz "\nDigite uma string: "
	insere_caractere: .asciiz "\nDigite um caractere: "
	caracteres_iguais: .asciiz "Quantidade do caractere informado na string: "
	mai�scula: .asciiz "\nQuantidade de caracteres mai�sculos: "
	min�scula: .asciiz "\nQuantidade de caracteres min�sculos: "
	palavra_invertida: .word
	escolha: .asciiz
	.space 50
	falso: .asciiz "\nN�o � palindromo"
	verdadeiro: .asciiz "\n� palindromo"
	
.text
menu:
	li $v0, 4
	la $a0, op��es
	syscall
	
	li $v0, 5
	syscall
	
	beq $v0, 1, OP��O1
	beq $v0, 2, OP��O2
	beq $v0, 3, OP��O3
	beq $v0, 4, FIM
	j menu
	
	OP��O1:
		jal palindromo
		j menu
	OP��O2:
		jal contagem_mai�scula_e_min�scula
		j menu
	OP��O3:
		jal contagem_caractere_escolhido
		j menu
palindromo:					#--------------- Op��o 1 ---------------
	
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
		beq $t3, 10, �_palindromo
		bne $t2, $t3, n�o_palindromo
		addi $t0, $t0, 1
		addi $t1, $t1, 1
		j testa_palindromo
	
	n�o_palindromo:
		li $v0, 4
		la $a0, falso
		syscall
		jr $ra
		
	�_palindromo:
		li $v0, 4
		la $a0, verdadeiro
		syscall
		jr $ra

contagem_mai�scula_e_min�scula:			#--------------- Op��o 2 ---------------
	
	li $v0, 4
	la $a0, insere_string
	syscall

	li $v0, 8
	la $a0, 0($sp)
	li $a1, 30
	syscall
	move $t2, $a0
	
	li $t0, 0	#contador de letras mai�sculas
	li $t1, 0	#contador de letras min�sculas
	
	contagem_mai�scula:
		lb $t3, ($t2)
		beq $t3, 10, imprime
		blt $t3, 65, pr�xima
		bgt $t3, 90, contagem_min�scula
		addi $t0, $t0, 1	#se chegou aqui � mai�scula
		j pr�xima
	
	contagem_min�scula:
		blt $t3, 97, pr�xima
		bgt $t3, 122, pr�xima
		addi $t1, $t1, 1	#se chegou aqui � min�scula
		
	pr�xima:
		addi $t2, $t2, 1	#avan�a para o pr�ximo caractere da string
		j contagem_mai�scula
		
	imprime:
		li $v0, 4
		la $a0, mai�scula
		syscall
		
		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0, min�scula
		syscall
		
		li $v0, 1
		move $a0, $t1
		syscall
		jr $ra
	
contagem_caractere_escolhido:			#-------------- Op��o 3 ---------------

	li $v0, 4
	la $a0, insere_caractere
	syscall
	
	li $v0, 12
	syscall
	move $t1, $v0 	#endere�o caractere
	
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
		bne $t3, $t1, pr�ximo_caractere
		addi $t0, $t0, 1	#se chegou aqui � igual
	
	pr�ximo_caractere:
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
