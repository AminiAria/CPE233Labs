.EQU 	A = 95			;95
.EQU	B = 255			;255
.EQU	C = 255			;255
.EQU	LEDS = 0x40

.CSEG
.ORG 0x01

		MOV		R5, 8
start:	MOV		R3, 1	;parameter register
		MOV		R4, 0x01;LED register
nextLED:OUT		R4, LEDS
		CLC
		ST		R3, 0
		CALL	delay
		LD		R3, 0
		ADD		R3, 1
		CMP		R5, R3
		BRCS	start
		SEC		
		LSL		R4
		BRN		nextLED
		

delay:	MOV 	R0, A
loop3:	MOV		R1, B
loop2:	MOV 	R2,	C
loop1:	SUB 	R2, 1
		BRNE	loop1
		SUB 	R1, 1
		BRNE	loop2
		SUB		R0, 1
		BRNE	loop3
		SUB		R3, 1
		BRNE	delay
		RET
		
		
		
