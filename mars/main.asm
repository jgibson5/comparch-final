 .data
 f1out:   	.asciiz "unsorted.txt"      # filename for output
f2out:	.asciiz "sorted.txt"      # filename for output
#buffer: 	.asciiz "The quick brown fox jumps over the lazy dog."
.text

li $s4, 1024

#Allocate memory	
	#array to be sorted
	li $v0, 9 #sbrk
	move $a0, $s4  #$s4/4 4 byte ints
	syscall
	
#keep pointer in $s0
#mutable pointer in $s1
move $s0, $v0
move $s1, $s0

#Set up limit
add $s2, $s1, $s4

store_rand:
	li $v0, 41 #get rand int
	li $a0, 0
	syscall

	sw $a0, 0($s1) 
	
	addi $s1, $s1, 4
	bne $s1, $s2, store_rand
#NULL terminate
li $a0, 0
sw $a0, 4($s2)

li $v0, 13 				#Open file
la $a0, f1out			#Load address
li   $a1, 1        			#Open for writing (flags are 0: read, 1: write)
li   $a2, 0				#Ignore mode
syscall
move $s3, $v0 			#Save result

move $a0, $s0
move $a1, $s4
move $a2, $s3
jal write_file


move $a0, $s0
move $a1, $s4
jal sort
move $s0, $v0

li $v0, 13 				#Open file
la $a0, f2out			#Load address
li   $a1, 1        			#Open for writing (flags are 0: read, 1: write)
li   $a2, 0				#Ignore mode
syscall
move $s3, $v0 			#Save result

move $a0, $s0
move $a1, $s4
move $a2, $s3
jal write_file

#exit
li $v0, 10
syscall



li $v0, 34  			#print unsigned int (hex)
move $a0, $s2 
syscall





##Writes integer data to file as hex
#$a0 - address of numbers
#$a1 - number of bytes of numbers
#$a2 - file dexcriptor to write to
write_file:
	move $t0, $a0
	move $t1, $a1 	
	add $t2, $t1, $t0 #Limit
	
	#Allocate
	li $v0, 9 #sbrk
	sll $a0, $a1, 1  #twice as much space as before
	syscall
	
	move $a0, $v0
	#Go through all of the numbers 
	#Counter: $t9
	li $t9, 0
	loop_ints:
	lw $t4, 0($t0)
	
		#Each number is 8 4 bit chars (0-F)
		#Store chars in $t5	
		new_char:
		li $t5, 0
	
			#store current char in lower 8 bits of $t3
			#and shift $t3 (int) and $t5 (4 chars) 
			loop_chars:
			addi $t9, $t9, 1
			andi $t3, $t4, 0x0000000F
			blt $t3, 10, if
			addi $t3, $t3, 55 #A-F
			j end
			if:
			addi $t3, $t3, 48 #0-9
			end:
	
			srl $t4, $t4, 4
		 	sll $t5, $t5, 8
		 	add $t5, $t5, $t3
		 	#handle counter
		 	andi $t8, $t9, 3
		 	bnez $t8, loop_chars
	 	
	 	andi $t8, $t9, 4
	 	bnez $t8, high_bits 
	 	low_bits:
	 	sw $t5, -4($a0)
	 	j end_bits
		high_bits:
		sw $t5, 4($a0)
		end_bits:
		addi $a0, $a0, 4
		andi $t8, $t9, 	7
		bnez $t8, new_char
	
	addi $t0, $t0, 4 #Next int
	bne $t0, $t2, loop_ints
	
	#Write to file (descriptor $a2)
	move  $a1, $v0   # address of buffer from which to write
	li   $v0, 15       # system call for write to file
	move $a0, $a2      # file descriptor 
	sll $a2, $t1, 1      # hardcoded buffer length
	syscall            # write to file

jr $ra
#End write_file


##Sorts a list
	#$a0 - address of first element
	#$a1 - number of bytes of numbers
##Returns
	#$v0 - address of sorted list
	#$v1 - len of sorted list
sort:
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
jal sort


addi $a0, $s2, 4
add $a1, $s0, $s1
sub $a1, $a1, $a0
jal sort

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
	
