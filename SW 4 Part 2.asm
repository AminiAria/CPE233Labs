.DSEG
.ORG 0x00
.DB		10,9,8,7,6,5,4,3,2,1
.CSEG
.ORG 21

start:		MOV		R4, 10
reset:		MOV 	R0, 0
			MOV 	R1, 1
loop:		CMP		R4, R1
			BREQ	NextRound
			LD		R2, (R0)
			LD		R3, (R1)
			CMP 	R2, R3
			BRCC	swap	;if R2 > R3
			BRN		NextMem
		
swap:		ST		R3, (R0)	;smaller number (R3) goes into the location R2 was in 
			ST		R2, (R1)
			BRN		NextMem
		
NextMem:	ADD	R0, 1
			ADD	R1, 1
			BRN	loop
			
		
NextRound:	SUB	R4, 1
			CMP	R4, 0
			BREQ	start
			BRN	reset
			

