;SW 1
;By: Aria Amini

.CSEG
.ORG 0x01 ;code starts here

start:		IN		R0, 0x03	;takes three inputs
			IN		R1, 0x03
			IN		R2, 0x03
			ADD		R0, R1		;first add R1 to R0 and store to R0
			ADD		R0, R2		;then add R2 to R0
			OUT		R0, 0x04	;Output R0 to port 4
			BRN		start		;endless loop
			
			