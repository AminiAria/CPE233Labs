;Aria Amini


.CSEG
.ORG	0x01

start:		IN		R0,0x0A
			MOV		R3, 0
			MOV		R1, R0
			AND		R0, 0x0F	;R0 contains the least significant 4 bits
			AND		R1, 0xF0	;R1 contains the most significant 4 bits
check:		CMP 	R1, 0		;R2-R3
			BRNE	mult		;Z flag is 0, if R2 and R3 are not equal
			OUT		R3, 0x0B
			BRN		start
				
				
			
			
mult:		ADD		R3, R0
			SUB		R1, 0x10
			BRN		check
			
			
			