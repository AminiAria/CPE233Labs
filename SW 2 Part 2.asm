;Aria Amini
;SW 2 Part 2


.CSEG
.ORG		0x01

start:		IN		R1, 0x03
			MOV		R2, R1				;puts R1 into R2
			LSR 	R1					;shifts R1
			BRCS	odd					;if carry is set, it is odd so branch
			LSR		R1					;shifts R1 again
			BRCS	not_mult_not_odd	;if carry is set, it is not odd and not a mult of 4
			EXOR	R2, 0xFF			;if number is mult of 4, invert bits
			OUT		R2,0x04				
			BRN		start

odd:		ADD		R2, 17		
			CLC							;need to clear carry before shift
			LSR		R2					;divide by 2
			OUT		R2, 0x04
			BRN		start

not_mult_not_odd:		SUB		R2, 1
						OUT		R2, 0x04
						BRN		start
						
			
			