;;SW 4 Part 1

.DSEG
.ORG 0x00
.DB		0,1,1,2,3,5,8,13,21,34,55,89,144,233

.CSEG
.ORG 29

start:		MOV 	R0, 0 ;address register	
			MOV		R1, 3; second address register
NextReg:	CMP		R1, 14
			BREQ	start
			LD 		R2, (R0)
			LD		R3, (R1)
			SUB		R3, R2
			OUT		R3, 0x0B
			ADD		R0, 1
			ADD		R1, 1
			BRN		NextReg



