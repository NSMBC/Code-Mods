@ Credit: MeroMero

@Write BG 8192 bytes later in the VRAM
ncp_call(0x020BD048,0)
	ADD		R1, R3, #0xB000
	BX		LR
	
@Write FG 8192 bytes later in the VRAM
ncp_call(0x020BD094,0)
	ADD		R1, R3, #0x6000
	BX		LR

@Begin lecture of BG and FG nsc 2 rows later
ncp_call(0x020BCBB4,0)
	MOV		R5, #0
	MOV		R7, #0x400
	SUB		R7, R7, #1
	LDRH	R4, [R11]
	AND		R6, R4, R7
	CMP		R6, #0x100			@Take into account Tile-Share
	ADDCS	R4, R4, #0x80
	STRH	R4, [R11], #2
	ADD		R5, R5, #1
	CMP		R5, #0x2000
	SUBCC	PC, PC, #0x24
	LDR		R4, =0x20CAD5C
	LDR		R4, [R4]
	CMP		R4, #0
	ADDEQ	PC, PC, #0x18
	LDR		R5, [R4, #-0xC]
	ADD		R5, R4, R5
	LDRH	R6, [R4]
	ADD		R6, R6, #0x80
	STRH	R6, [R4], #2
	CMP		R4, R5
	SUBCC	PC, PC, #0x18
	ADD		SP, SP, #0x24
	LDMFD	SP!, {R4-R11, PC}
	
@TEN animations for some tilesets
ncp_call(0x020B699C,0)
ncp_call(0x020B69BC,0)
ncp_call(0x020B6E98,0)
	ADD		R1, R1, #0x2000
	MOV		R2, #0x180
	BX		LR
	
ncp_call(0x020B6DB8,0)
	ADD		R1, R1, #0x2000
	MOV		R2, #0x400
	BX		LR
	
ncp_call(0x020B710C,0)
ncp_call(0x020B712C,0)
ncp_call(0x020B714C,0)
ncp_call(0x020B7168,0)
ncp_call(0x020B720C,0)
ncp_call(0x020B722C,0)
ncp_call(0x020B724C,0)
ncp_call(0x020B731C,0)
ncp_call(0x020B733C,0)
ncp_call(0x020B735C,0)
ncp_call(0x020B737C,0)
ncp_call(0x020B739C,0)
ncp_call(0x020B73B8,0)
ncp_call(0x020B744C,0)
ncp_call(0x020B746C,0)
ncp_call(0x020B748C,0)
ncp_call(0x020B751C,0)
ncp_call(0x020B753C,0)
ncp_call(0x020B755C,0)
ncp_call(0x020B757C,0)
ncp_call(0x020B7598,0)
ncp_call(0x020B762C,0)
ncp_call(0x020B764C,0)
ncp_call(0x020B766C,0)
ncp_call(0x020B768C,0)
ncp_call(0x020B76A8,0)
ncp_call(0x020B77E0,0)
ncp_call(0x020B7804,0)
ncp_call(0x020B7828,0)
ncp_call(0x020B78C4,0)
ncp_call(0x020B78E4,0)
ncp_call(0x020B7904,0)
ncp_call(0x020B7920,0)
	ADD		R1, R1, #0x2000
	MOV		R2, #0x100
	BX		LR
	
@Change which Tile Number yields which texture for SubNohara
ncp_jump(0x020B00EC,0)
	CMP		R1, #0x540
	ADDCC	PC, PC, #0x54
	LDR		R2, =0x545
	CMP		R1, R2
	BHI		0x20B0184
	SUB		R3, R1, #0x540
	MOV		R0, #0x65
	CMP		R3, #1
	MOVEQ	R0, #0x68
	CMP		R3, #2
	MOVEQ	R0, #0x62
	CMP		R3, #3
	MOVEQ	R0, #0x67
	CMP		R3, #4
	MOVEQ	R0, #0x6A
	CMP		R3, #5
	MOVEQ	R0, #0x64
	MOV		R3, R0
	LDR		R0, =0x20CAD44
	LDR		R2, [R0]
	ADD		SP, SP, #4
	STRB	R3, [R2, LR]
	MOV		R0, R1
	LDMFD	SP!, {R4-R5, PC}
	CMP		R1, #0x530
	ADDCC	PC, PC, #0x2C
	LDR		R2, =0x539
	CMP		R1, R2
	BHI		0x20B0184
	SUB		R3, R1, #0x530
	ADD		R3, R3, #0x86
	AND		R3, R3, #0xFF
	LDR		R0, =0x20CAD44
	LDR		R2, [R0]
	ADD		SP, SP, #4
	STRB	R3, [R2, LR]
	MOV		R0, R1
	LDMFD	SP!, {R4-R5, PC}
	CMP		R1, #0x520
	BCC		0x20B0184
	LDR		R2, =0x529
	CMP		R1, R2
	BHI		0x20B0184
	SUB		R3, R1, #0x520
	ADD		R3, R3, #0x7A
	AND		R3, R3, #0xFF
	LDR		R0, =0x20CAD44
	LDR		R2, [R0]
	ADD		SP, SP, #4
	STRB	R3, [R2, LR]
	MOV		R0, R1
	LDMFD	SP!, {R4-R5, PC}
	
@Broken flagpole dynamic palette
ncp_call(0x02130214,12)
	LDRH	R0, [R4, #0xC]
	CMP		R0, #0x24
	ADDNE	PC, PC, #0x24
	LDR		R0, =0x20CAD30
	LDR		R0, [R0]
	LDR		R1, =0x635B635A
	LDR		R2, =0x635D635C
	LDRB	R3, [R4, #0xB]
	ANDS	R3, R3, #0x10
	LDRNE	R1, =0x737B737A
	LDRNE	R2, =0x737D737C
	STR		R1, [R0, #0x174]
	STR		R2, [R0, #0x17C]
	LDR		R1, [R4, #0x64]
	BX		LR