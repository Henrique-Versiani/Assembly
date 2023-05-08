.data
	string1: .asciiz "\nEsse programa calcula a área de triângulos e retângulos"
	string2: .asciiz "\n\nQual área você quer calcular (1 para triângulo e 2 para retângulo)?\n"
	string3: .asciiz "\nDigite o valor de a: "
	string4: .asciiz "\nDigite o valor de b: "
	string5: .asciiz "\nA área é igual a: "
	.space 10
.text
	li $v0, 4
	la $a0, string1
	syscall
	menu:
		li $v0, 4
		la $a0, string2
		syscall
		
		li $v0, 5
		syscall
		
		beq $v0, 1, OPÇÃO1
		beq $v0, 2, OPÇÃO2
		j menu 
		
	OPÇÃO1:
		jal área_triângulo
		j menu
	OPÇÃO2:
		jal área_retângulo
		j menu
		
	área_triângulo:
		li $v0, 4
		la $a0, string3
		syscall
		
		li $v0, 5
		syscall
		move $t0, $v0
		
		li $v0, 4
		la $a0, string4
		syscall
		
		li $v0, 5
		syscall
		move $t1, $v0
		
		li $t2, 0	#acumulador
		multiplica_triângulo:
			beq $t1, $zero, divide
			add $t2, $t2, $t0
			addi $t1, $t1, -1
			j multiplica_triângulo
			
		divide:
			srl $t2, $t2, 1
			li $v0, 4
			la $a0, string5
			syscall
			
			li $v0, 1
			la $a0, ($t2)
			syscall
			
			jr $ra
		
	área_retângulo:
		
		li $v0, 4
		la $a0, string3
		syscall
		
		li $v0, 5
		syscall
		move $t0, $v0
		
		li $v0, 4
		la $a0, string4
		syscall
		
		li $v0, 5
		syscall
		move $t1, $v0
		
		li $t2, 0	#acumulador
		multiplica_retângulo:
			beq $t1, $zero, fim_retângulo
			add $t2, $t2, $t0
			addi $t1, $t1, -1
			j multiplica_retângulo
			
		fim_retângulo:
			li $v0, 4
			la $a0, string5
			syscall
			
			li $v0, 1
			la $a0, ($t2)
			syscall
		
			jr $ra