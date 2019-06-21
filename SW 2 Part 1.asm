;Aria Amini
;SW 2 Part 1

.CSEG
.ORG 0x01

start:		IN		R0, 0x03
			MOV		R1, 128
			CMP		R0, R1
			BRCS	lesser	;carry is set if number is less
			CLC				;need to clear carry before shift
			LSR		R0		;divide by 2
			CLC
			LSR		R0		;divide by 2 again
			OUT		R0, 0x04
			BRN		start
			
lesser:		CLC				;clear carry before shift
			LSL		R0		;left shift to mult by 2
			OUT		R0, 0x04
			BRN		start
			

			