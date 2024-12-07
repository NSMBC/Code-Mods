@ Credit: MeroMero

ncp_call(0x0218C560,109)
	LDR		R0, =0x5FC				@Increase heap for Snake Blocks
	BX		LR
	
ncp_call(0x0218A510,109)
	LDR		R3, [R4, #8]			@Load Actor Data into R3
	ANDS	R3, R3, #1				@Check Nybble 11 Bit 0
	LDREQ	R1, =0x218C600			@If not set then Snake Blocks move on their own
	LDMIA	R1, {R1, R2}
	BX		LR
	
ncp_call(0x02189A84,109)
	LDR		R1, [R4, #8]			@Load Actor Data into R1
	ANDS	R1, R1, #2				@Check Nybble 11 Bit 1
	LDRNE	R0, =IceSnakeBlocks		@If set then load the Ice Snake Blocks graphics
	ADD		R1, R3, #0x8000
	BX		LR
	
ncp_call(0x02189AF8,109)
	LDR		R1, [R6, #8]			@Load Actor Data into R1
	ANDS	R1, R1, #2				@Check Nybble 11 Bit 1
	LDRNE	R0, =IceSnakeBlocks		@If set then load the Ice Snake Blocks graphics
	ADD		R1, R3, #0x8000
	BX		LR

ncp_call(0x02189FE8,109)
	MOV		R6, #0xD				@Get pointer for Snake Block jyotyu map16
	LDR		R3, [R4, #8]			@Load Actor Data into R3
	ANDS	R3, R3, #2				@Check Nybble 11 Bit 1
	MOVNE	R6, #0x85				@If set then get pointer for Ice Snake Block jyotyu map16
	BX		LR

ncp_call(0x0218B488,109)
ncp_call(0x0218B4DC,109)
	LDR		R1, [R4, #8]			@Load Actor Data into R1
	ANDS	R1, R1, #2				@Check Nybble 11 Bit 1
	MOVNE	R3, #0x85				@If set then get pointer for Ice Snake Block jyotyu map16
	MOV		R1, R12, LSL #4
	BX		LR
	
ncp_call(0x0218A3B8,109)				@First step to allow looping
	AND		R2, R1, #7
	CMP		R2, #5
	MOVEQ	R2, #0
	BX		LR
	
ncp_call(0x02189CD8,109)				@Second step to allow looping
	ADD		R2, R2, R3
	CMP		R1, #1
	ADDEQ	R12, R2, #1
	STREQ	R12, [R5, #0x5F4]		@Store Snake Block head position on node 1
	LDREQB	R12, [R5, #0x3F4]
	SUBEQ	R12, R2, R12
	STREQ	R12, [R5, #0x5F8]		@Store Snake Block tail position on node 1
	BX		LR
	
ncp_call(0x0218B5C8,109)				@Main function for looping
	LDR		R0, [R5, #8]
	MOV		R0, R0, LSR #0x1C
	AND		R0, R0, #7
	CMP		R0, #5					@Allow looping only if Nybble 4 value is 5 or 13 (0xD)
	BNE		.Return
	LDR		R0, [R5, #0x4D0]
	LDR		R4, [R5, #0x4D4]
	CMP		R4, R0
	LDRHI	R4, [R5, #0x5F4]
	STRHI	R4, [R5, #0x4D4]
	LDR		R0, [R5, #0x578]
	LDR		R4, [R5, #0x57C]
	CMP		R4, R0
	LDRHI	R4, [R5, #0x5F8]
	STRHI	R4, [R5, #0x57C]
.Return:
	MOV		R0, #1
	LDMFD	SP!, {R4, PC}
	
ncp_jump(0x0218A410,109)
	AND		R1, R1, #3
	CMP		R1, #0
	MOVEQ	R1, #0x1000				@Default speed is still value 0
	CMP		R1, #1
	MOVEQ	R1, #0x800				@Half speed is still value 1
	CMP		R1, #2
	MOVEQ	R1, #0x400				@NEW: Quarter speed is value 2
	CMP		R1, #3
	MOVEQ	R1, #0x2000				@NEW: Double speed is value 3
	CMP		R1, #0x400				@Error handler: Check if speed has been set
	MOVCC	R1, #0x1000				@If not set to default speed
	B		0x218A418
	
.data
.balign 4
IceSnakeBlocks:
	.word 0x41F820F8
	.word 0xFFFF1102