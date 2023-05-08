.data
	string1: .asciiz "\nEsse programa calcula a �rea de tri�ngulos e ret�ngulos"
	string2: .asciiz "\n\nQual �rea voc� quer calcular (1 para tri�ngulo e 2 para ret�ngulo)?\n"
	string3: .asciiz "\nDigite o valor de a: "
	string4: .asciiz "\nDigite o valor de b: "
	string5: .asciiz "\nA �rea � igual a: "
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
		
		beq $v0, 1, OP��O1
		beq $v0, 2, OP��O2
		j menu 
		
	OP��O1:
		jal �rea_tri�ngulo
		j menu
	OP��O2:
		jal �rea_ret�ngulo
		j menu
		
	�rea_tri�ngulo:
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
		multiplica_tri�ngulo:
			beq $t1, $zero, divide
			add $t2, $t2, $t0
			addi $t1, $t1, -1
			j multiplica_tri�ngulo
			
		divide:
			srl $t2, $t2, 1
			li $v0, 4
			la $a0, string5
			syscall
			
			li $v0, 1
			la $a0, ($t2)
			syscall
			
			jr $ra
		
	�rea_ret�ngulo:
		
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
		multiplica_ret�ngulo:
			beq $t1, $zero, fim_ret�ngulo
			add $t2, $t2, $t0
			addi $t1, $t1, -1
			j multiplica_ret�ngulo
			
		fim_ret�ngulo:
			li $v0, 4
			la $a0, string5
			syscall
			
			li $v0, 1
			la $a0, ($t2)
			syscall
		
			jr $ra