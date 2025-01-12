@ Credit: Skawo
@ shifts podoboos by half a tile when nybble set

ncp_call(0x02147F14,48)
	MOV     R4, R0
	LDR		R1, [R4, #8]
	LSR     R1, #0x8
	ANDS 	R1, R1, #0xF
	BXEQ    LR
	MOV     R1, #0x8000
	LDR     R0, [R4, #0x60]
	ADD     R0, R1
	STR     R0, [R4, #0x60]
	BX      LR