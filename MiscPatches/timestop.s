@ Credit: MeroMero

ncp_call(0x020AFA80,0)
	LDRB	R1, [R0, #4]
	LDR		R2, =0x20CA850
	ANDS	R1, R1, #0x80		@Check if Event ID 40 is set
	LDRB	R0, [R2]			@Load Freeze Actor bit
	LDRB	R1, [R2, #0x48]		@Load Freeze Timer bit
	ORRNE	R0, R0, #4			@If yes set Freeze Actor
	ORRNE	R1, R1, #1			@and Freeze Timer
	BICEQ	R0, R0, #4			@If not unset Freeze Actor
	BICEQ	R1, R1, #1			@and Freeze Timer
	STRB	R0, [R2]			@No matter the result
	STRB	R1, [R2, #0x48]		@Store both settings
	LDR		R0, =0x208AF3C
	MOV		R1, #0
	BX		LR
	
ncp_call(0x020A261C,0)
	AND		R0, R0, #0x22		@Don't check for Freeze Actor bit
	BX		LR
	
ncp_call(0x02168E70,54)
	LDRH	R0, [R7, #0xC]
	CMP		R0, #0x8C			@Check if Actor is Single Event Chainer
	BNE		.Return
	ADD		R5, R7, #0x33C
	LDRB	R4, [R5]			@Get Trigger ID
	LDRB	R5, [R5, #1]		@Get Target ID
	CMP		R4, #0x28			@Check if Target ID is Time Stop ID
	BNE		.Return
	LDR		R0, =0x208AF3C
	ADD		R6, R0, #4
	ADD		R9, R0, #0x48
	SUB		R5, R5, #1
	ANDS	R7, R5, #0x20
	MOVNE	R0, R6
	LDR		R0, [R0]
	LDR		R6, [R6]
	MOV		R8, #1
	AND		R7, R5, #0x1F
	MOV		R8, R8, LSL R7
	ANDS	R6, R6, #0x80		@Check if Target ID 40 is set
	BEQ		.Return
	ANDS	R0, R0, R8			@Check if Trigger ID is set
	BEQ		.Return
	LDR		R0, [R9, R5, LSL #2]
	STR		R0, [R9, #0x9C]
.Return:
	MOV		R0, #1
	BX		LR