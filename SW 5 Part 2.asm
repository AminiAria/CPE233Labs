.EQU 	A = 95
.EQU	B = 255
.EQU	C = 255

.CSEG
.ORG 0x03

		IN		R3, 0x0A
		MOV 	R0, A
loop3:	MOV		R1, B
loop2:	MOV 	R2,	C
loop1:	SUB 	R2, 1
		BRNE	loop1
		SUB 	R1, 1
		BRNE	loop2
		SUB		R0, 1
		BRNE	loop3
		OUT		R3, 0x0A
		
		
		
