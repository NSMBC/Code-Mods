@ Credit: MeroMero

@Luigi can spawn clones too
ncp_call(0x0215AEC4,54)
	LDR		R1, =0x2085A50
	LDRB	R1, [R1]			@Get Player Number
	MOV		R1, R1, LSL #4
	AND		R1, R1, #0x10
	ORR		R1, R1, R3			@Incorporate Player Number into cloned Player Actor Data (ID 21)
	BX		LR

@Progress bar always follows the original
ncp_call(0x020BECD4,0)
	LDR		R2, =0x208B35C
	LDR		R2, [R2]
	LDR		R2, [R2, #0x908]
	BX		LR
	
@Get the right Player Actor on Stomp
ncp_call(0x0209A82C,0)
	LDR		R0, =PseudoStack
	LDR		R5, [R10, #4]
	STR		R5, [R0]			@Store the offset of the right Player Actor
	MOV		R5, R3
	BX		LR
	
ncp_call(0x0209A83C,0)
	LDR		R0, =PseudoStack
	LDR		R0, [R0]			@Retrieve the offset of the right Player Actor
	BX		LR
	
@Get the right Player Actor on Grab
ncp_call(0x020E063C,10)
	LDR		R0, =0x478			@Increase heap for Koopa Troopa
	BX		LR
	
ncp_call(0x020E066C,10)
	LDR		R0, =0x478			@Increase heap for Koopa Paratroopa
	BX		LR
	
ncp_call(0x02155EA8,54)
	LDR		R0, =0x50C			@Increase heap for Springboard
	BX		LR
	
ncp_call(0x0214E2D4,42)
	LDR		R0, =0x4C0			@Increase heap for Bob-Omb
	BX		LR
	
ncp_call(0x02151748,42)
	LDR		R0, =0x634			@Increase heap for Spiny
	BX		LR

ncp_call(0x0215179C,42)
	LDR		R0, =0x634			@Increase heap for Roof Spiny
	BX		LR
	
ncp_call(0x021775B8,68)
	LDR		R0, =0x598			@Increase heap for Buzzy Beetle
	BX		LR
	
ncp_call(0x0212B27C,11)
	CMP		R1, #0
	BEQ		.Return
	LDRH	R0, [R1, #0xC]		@Get the Actor ID
	CMP		R0, #0x23			@Bob-Omb
	BEQ		.SpecialCases
	CMP		R0, #0x28			@Spiny
	BEQ		.SpecialCases
	CMP		R0, #0x36			@Buzzy Beetle
	BEQ		.SpecialCases
	CMP		R0, #0x5E			@Koopa Troopa
	BEQ		.SpecialCases
	CMP		R0, #0x5F			@Koopa Paratroopa
	BEQ		.SpecialCases
	CMP		R0, #0x7B			@Roof Spiny
	BEQ		.SpecialCases
	CMP		R0, #0xED			@Springboard
	BNE		.Return
.SpecialCases:
	LDR		R0, [R1, #-0xC]		@Get heap size for grabbed Actor
	SUB		R0, R0, #4			@Subtract 4 to get the offset…
	STR		R2, [R1, R0]		@…where the Player Actor will be stored
.Return:
	LDR		R0, [R2, #0x688]
	BX		LR

ncp_call(0x0209A174,0)
	LDR		R0, [R8, #-0xC]
	SUB		R0, R0, #4
	LDR		R0, [R8, R0]		@Retrieve the offset of the right Player Actor
	BX		LR
	
ncp_call(0x0209FB64,0)
	LDR		R0, [R4, #-0xC]
	SUB		R0, R0, #4
	LDR		R0, [R4, R0]		@Retrieve the offset of the right Player Actor
	BX		LR
	
.data
.balign 4
PseudoStack:
	.word 0x0