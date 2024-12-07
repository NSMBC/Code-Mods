@ Credit: MeroMero

ncp_call(0x02001D9C)
	MOV		R1, R0, LSR #0x14
	AND		R1, R1, #0x1F
	ANDS	R0, R0, #0x10000000
	LDR		R0, =0x105E
	BNE		.Pipes
	AND		R1, R1, #0xF
	CMP		R1, #0xA
	ADDCC	R0, R1, R0
	ADDCC	R0, R0, #0x21
	B		.Return
.Pipes:
	ADD		R0, R1, R0
	ADD		R0, R0, #1
.Return:
	ADD		LR, LR, #0x34
	BX		LR
	
ncp_call(0x02001F28)
	LDR		R0, =PseudoStack
	STR		R5, [R0]
	STR		LR, [R0, #4]
	MOV		R5, #0
.LoopModels:
	LDR		R0, =0x105E
	ADD		R0, R0, R5
	MOV		R1, #0
	BL		0x2009C64
	ADD		R5, R5, #1
	CMP		R5, #0x2B
	BCC		.LoopModels
	LDR		R5, =PseudoStack
	LDR		LR, [R5, #4]
	LDR		R5, [R5]
	ADD		LR, LR, #0x14
	BX		LR
	
ncp_call(0x02001D04)
	MOV		R0, #0x800			@Small is 8x8 instead of 9x9
	BX		LR
	
ncp_call(0x02001D2C)
	MOV		R0, #0x1000			@Normal is 16x16 instead of 18x18
	BX		LR
	
.data
.balign 4
PseudoStack:
	.word 0x0
	.word 0x0