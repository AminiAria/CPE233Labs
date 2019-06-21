;SW 1 Part 2
;By: Aria Amini




.CSEG
.ORG 0x01	;starts in this register

start:		IN			R0, 0x03	;takes input from port 3
			EXOR		R0, 0xFF	;takes inverse by doing EXOR with 0xFF
			ADD			R0, 1		;add one to the result
			OUT			R0, 0x04	;output to port 4
			BRN			start		;repeats
			
													