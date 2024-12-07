@ Credit: MeroMero

ncp_call(0x0215B658,54)				@Used Block
ncp_call(0x0215D0FC,54)
ncp_call(0x02185E04,98)
ncp_call(0x02186F0C,98)
	MOV		R2, #0
	LDR		R1, =0x208B170
	LDR		R1, [R1]
	CMP		R1, #0
	BXEQ	LR
	LDRB	R1, [R1, #2]
	CMP		R1, #0x4B
	MOVHI	R1, #0
	LDR		R3, =0x20C93B8
	LDRB	R3, [R3, R1]
	MOV		R3, R3, LSL #5
	LDR		R1, =0x2129368
	LDRH	R1, [R1]
	ADD		R1, R1, R3
	ADD		R3, R0, #0x160
	STRH	R1, [R3]
	BX		LR
	
ncp_call(0x0215B620,54)				@Flying Block
ncp_call(0x0215B6C8,54)
ncp_call(0x02185DD4,98)				@Hanging Bouncing Block
ncp_call(0x0218641C,98)
ncp_call(0x02186EDC,98)				@Hanging Block
ncp_call(0x02187794,98)
	STMFD	SP!, {R1-R2, LR}
	LDR		R0, =0x1052
	BL		.Hatena
	LDMFD	SP!, {R1-R2, PC}
	
ncp_call(0x0215B5E0,54)				@Flying Block
ncp_call(0x0215B6A4,54)
ncp_call(0x0215D04C,54)				@Red Flying Block
ncp_call(0x0215D150,54)
	STMFD	SP!, {R1-R2, LR}
	LDR		R0, =0x1056
	BL		.Hatena
	LDMFD	SP!, {R1-R2, PC}

ncp_call(0x021856F0,99)				@Bouncing Bricks
ncp_call(0x02185C74,99)
	STMFD	SP!, {R1-R2, LR}
	LDR		R0, =0x105A
	BL		.Hatena
	LDMFD	SP!, {R1-R2, PC}

.Hatena:
	STMFD	SP!, {LR}
	LDR		R1, =0x208B170
	LDR		R1, [R1]
	CMP		R1, #0
	LDMEQFD	SP!, {PC}
	LDRB	R1, [R1, #2]
	CMP		R1, #0x4B
	MOVHI	R1, #0
	LDR		R2, =0x20C93B8
	LDRB	R2, [R2, R1]
	ADD		R0, R0, R2
	LDMFD	SP!, {PC}
	
ncp_call(0x020BAA54,0)				@Blockhopper
	STMFD	SP!, {R1-R4}
	LDR		R2, =0x50E
	BL		.Camouflage
	LDR		R2, =0x511
	BL		.Camouflage
	LDMFD	SP!, {R1-R4, PC}
	
.Camouflage:
	STMFD	SP!, {LR}
	LDR		R1, =0x2087620
	MOV		R3, #0
.LoopCamouflage1:
	LDRH	R4, [R1]
	CMP		R4, R2
	BEQ		.SuccessLoopCamouflage1
	SUB		R1, R1, #0x18
	ADD		R3, R3, #1
	CMP		R3, #0x100
	BCC		.LoopCamouflage1
	LDMFD	SP!, {PC}
.SuccessLoopCamouflage1:
	LDR		R4, [R1, #0xC]
	ADD		R4, R4, #0x8A
	MOV		R1, R0, LSL #1
	MOV		R3, #0
.LoopCamouflage2:
	AND		R2, R3, #1
	ADD		R2, R2, R1
	ADD		R2, R2, #0x31
	STRB	R2, [R4], #0x10
	ADD		R3, R3, #1
	CMP		R3, #4
	BCC		.LoopCamouflage2
	LDMFD	SP!, {PC}