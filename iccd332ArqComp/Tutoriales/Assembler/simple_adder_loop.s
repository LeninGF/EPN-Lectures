.global _start
_start:
	mov r0, #0
	mov r1, #4
	mov r2, #2
loop:	
	add r0,r1,r2
B loop
	