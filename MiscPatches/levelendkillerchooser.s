@ Credit: MeroMero

ncp_call(0x0209DF5C,0)
	STMFD	SP!, {R0-R1, R5, LR}
	STRB	R3, [R4, #0x3E7]
	MOV		R0, R7, LSR #3
	MOV		R1, R0, LSL #3
	SUB		R1, R7, R1
	MOV		R5, #1
.Division:
	CMP		R1, #0
	BEQ		.ResultDivision
	MOV		R5, R5, LSL #1
	SUB		R1, R1, #1
	B		.Division
.ResultDivision:
	LDR		R1, =ActorSpare
	LDRB	R1, [R1, R0]
	TST		R1, R5
	BEQ		.Return
	MOV		R2, #1
.Return:
	LDMFD	SP!, {R0-R1, R5, PC}
	
.data
.balign 1
ActorSpare:
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00100000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000
	.byte 0b00000000