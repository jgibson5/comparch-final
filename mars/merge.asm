##Sorts a list
	#$a0 - address of first element
	#$a1 - number of bytes of numbers
##Returns
	#$v0 - address of sorted list
	#$v1 - len of sorted list
merge_sort:
#$s0 - address of first element first half
#$s1 - len of first half (smaller)
#$s2 - len of smaller half
bgt $a1, 4, really_sort
move $v0, $a0
move $v1, $a1
jr $ra
really_sort:
sw $ra 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
addi $sp, $sp, -20


move $s0, $a0
srl $s1, $a1, 1
andi $s1, $s1, 0xFFFFFFFC
sub $s2, $a1, $s1
add $s3, $s0, $s1

move $a0, $s0
move $a1, $s1
jal merge_sort
move $s0, $v0
move $s1, $v1

move $a0, $s3
move $a1, $s2
jal merge_sort

move $a0, $s0
move $a1, $s1
move $a2, $v0
move $a3, $v1
jal merge 

#End sort
addi $sp, $sp, 20
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
jr $ra
  
  
  
 ##Merges two lists and returns their result
 #$a0 - address of start of first
 #$a1 - len (bytes) of first
 #$a2 - address of start of second
 #$a3 - len (bytes) of second
 merge:
move $t0, $a0

#Allocate result
li $v0, 9 #sbrk
add $a0, $a1, $a3  #sum of lengths
syscall

#$v0 - address of start of result (res of syscall)
#$v1 - len of result
move $v1, $a0
move $a0, $t0
#$t0 - Current index in first list
#$t1 - current index in second list
#$t2 - current value in first list
#$t3 - current value in second list
#$t5 - current index in res list
#$t6 -8 - end values for first, second, and res list indices
move $t0, $a0
move $t1, $a2
move $t5, $v0
add $t6, $a0, $a1
add $t7, $a2, $a3
add $t8, $v0, $v1
merge_loop:
	lw $t2, 0($t0)
	lw $t3, 0($t1)
	#Check if at end of first or second list
	bge $t0, $t6, dump_second
	bge $t1, $t7, dump_first
	
	blt $t3, $t2, merge_else
	sw $t2, 0($t5)
	addi $t0, $t0, 4
	j merge_cond_end
	merge_else:	
	sw $t3, 0($t5)
	addi $t1, $t1, 4
	merge_cond_end:
	addi $t5, $t5, 4
	bge $t8, $t5, merge_loop
	
end_merge:
jr $ra

dump_second:
	sw $t3, 0($t5)
	addi $t1, $t1, 4
	addi $t5, $t5, 4
	lw $t3, 0($t1)
	
	bgt $t8, $t5, dump_second
j end_merge

dump_first:
	sw $t2, 0($t5)
	addi $t0, $t0, 4
	addi $t5, $t5, 4
	lw $t2, 0($t0)
	
	bgt $t8, $t5, dump_first
j end_merge
