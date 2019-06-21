.EQU SWITCHES = 0x20
.EQU LEDS = 0x40
.EQU 	A = 95			;95
.EQU	B = 255			;255
.EQU	C = 255			;255

.CSEG 
.ORG 0x01


start:		SEI
			MOV		R3, 0	;stores interrupts
main:		IN		R4, SWITCHES
			EXOR	R4, 0xFF
			OUT		R4, LEDS
			BRN		main
			
			

			
ISR:		ADD		R3, 1
			CMP		R3, 3
			BRCC	three_interrupts	;carry cleared if 3 interrupts
			RETIE						;carry set if less than 3 interrupts
	
									
three_interrupts:	OUT		R3, LEDS
					CALL	delay
					BRN		start
			
					
delay:	MOV 	R0, A
loop3:	MOV		R1, B
loop2:	MOV 	R2,	C
loop1:	SUB 	R2, 1
		BRNE	loop1
		SUB 	R1, 1
		BRNE	loop2
		SUB		R0, 1
		BRNE	loop3
		RET
					
							
.CSEG			
.ORG	0x3FF
			BRN		ISR
			
			
			