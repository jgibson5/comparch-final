##Sorts a list
#$a0 - address of first element
#$a1 - number of bytes of numbers
bubble_sort:
move $t8, $a1 
add $t9, $t8, $a0
li $t2, 1
move $a2, $a0
	sort_run:
	move $a0, $a2
	beqz $t2, end_sort
	li $t2, 0
	lw $t1, 0($a0)	
	addi $a0, $a0, 4
	
		sort_loop:
		beq $a0, $t9, sort_run
		move $t0, $t1
		lw $t1, 0($a0)	
		addi $a0, $a0, 4
		blt $t0, $t1, sort_loop
		sw $t0, -4($a0)
		sw $t1, -8($a0)
		move $t1, $t0
		li $t2, 1
		j sort_loop
		
	

end_sort:
#End sort
move $v0, $a0
move $v1, $a1
 jr $ra
  
