

.CSEG
.ORG 0x01


start:		IN		R0, 0x0A		;numerator
			IN		R1, 0x0A		;denominator
			MOV		R2, 0			;quotient register
			CMP		R1, 0
			BREQ	zero_divide
			
check:		CMP		R0, R1
			BRCC	divide
			OUT		R2, 0x0A		;quotient
			OUT		R0, 0x0B		;remainder
			BRN		start
			
divide:		SUB		R0, R1
			ADD		R2, 1
			BRN		check

zero_divide:	MOV		R3, 0xFF		;output 0xFF if dividing by 0
				OUT		R3, 0x0A
				OUT		R3, 0x0B
				BRN		start
			
			
			
			
			