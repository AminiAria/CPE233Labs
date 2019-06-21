;My first assebly rogram
;By: Aria Amini
; Date: 4/4/19
; Shows a couple of assembly instructions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.SSEG
.ORG 0x01

start:		MOV		R0, 0xF3
			IN		R1, 0x01
			ADD		R0, R1
			SUBC	R2, R3
			OUT		R1, 0x02
			BRN		start
			 

	