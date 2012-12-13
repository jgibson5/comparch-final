##Sorts a list
#$a0 - address of first element
#$a1 - number of bytes of numbers
insertion_sort:
#$t9 - address of last word
#$t0 - address of current lowest
#$t1 - current lowest
#$t2 - check against
#$t3 - address of $t2
#$t4 - address of first unordered piece 
add $t9, $a1, $a0
move $t4, $a0
	#Run through list, find lowest, append to front
	next_lowest:
	move $t0, $t4
	lw $t1, 0($t0)
	move $t3, $t0
		#Compare current lowest to next element
		find_lowest:
		beq $t3, $t9, end_find
		addi $t3, $t3, 4
		lw $t2, 0($t3)
		#If not ordered, swap $t1, $t2, update $t0
		blt $t1, $t2, find_lowest
		
		move $t5, $t2
		move $t2, $t1
		move $t1, $t5
		
		move $t0, $t3
		
		
		j find_lowest
		end_find:
	
	lw $t2, 0($t4)
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t2, 0($t0)
	bne $t4, $t9, next_lowest 

end_sort:
#End sort
 jr $ra
  