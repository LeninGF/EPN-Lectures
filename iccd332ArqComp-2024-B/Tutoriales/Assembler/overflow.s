.global _start
_start:
	mov r0, #0x00000000
	ldr r1, =0x80000000
	ldr r2, =0x80000000
loop:	
	adds r0,r1,r2
B loop
	