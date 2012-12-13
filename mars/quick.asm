##Sorts a list
	#$a0 - address of first element
	#$a1 - number of bytes of numbers
##Returns
	#$v0 - address of sorted list
	#$v1 - len of sorted list
quick_sort:
#$s0 - address of first element 
#$s1 - len of list
#$s2 - pivot index
bgt $a1, 8, really_sort
bgt $a1, 4, swap
move $v0, $a0
move $v1, $a1
jr $ra

swap:
lw $t1, 0($a0)
lw $t2, 4($a0)
ble $t1, $t2, return
sw $t1, 4($a0)
sw $t2, 0($a0)
return:
jr $ra  

really_sort:
sw $ra 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
addi $sp, $sp, -16


move $s0, $a0
move $s1, $a1
jal partition
move $s2, $v0

move $a0, $s0
sub $a1, $s2, $s0
jal quick_sort


addi $a0, $s2, 4
add $a1, $s0, $s1
sub $a1, $a1, $a0
jal quick_sort

move $v0, $s0
move $v1, $s1

#End sort
addi $sp, $sp, 16
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
jr $ra
  
  
  
 ##Partitions a list in place
  #$a0 - address of start of list
 #$a1 - len (bytes) of list
 partition: ##index = address
#$v0 - address of store index
#$t0 - address of decreasing index
#$t1 - value at $t0
#$t2 - value at $v0
#$t8 - pivot index
#$t9 - pivot value
move $v0, $a0
add $t0, $a0, $a1

addi $t0, $t0, -4

srl $t8, $a1, 1
andi $t8, $t8, 0xFFFFFFFC
add $t8, $t8, $a0
lw $t9, 0($t8)
lw $t1, 0($t0)
sw $t1, 0($t8)
sw $t9, 0($t0)
move $t8, $t0
addi $t0, $t0, -4
lw $t1, 0($t0)

partition_loop:
	
	blt $t1, $t9, swap_values
	
	addi $t0, $t0, -4
	lw $t1, 0($t0)
	bgt $t0, $v0, partition_loop
	j end_swap
	swap_values:
	lw $t2, 0($v0)
	sw $t1, 0($v0)
	sw $t2, 0($t0)
	move $t1, $t2
	addi $v0, $v0, 4
	bgt $t0, $v0, partition_loop
end_swap:

lw $t1, 0($v0)
bgt $t1, $t9, end_partition
addi $v0, $v0, 4
lw $t1, 0($v0)

end_partition:
sw $t9, 0($v0)
sw $t1, 0($t8)  

jr $ra
	
