@ Credit: MeroMero

ncp_jump(0x0200A4D4)
	B		0x200A4D8				@Disable titlescreen cutscene by Skawo

ncp_call(0x020CDD94,9)
	STMFD	SP!, {LR}
	BL		0x20099C8				@Load Title Logo on extended palette mode
	LDR		R0, =0x20DB9F4			@Factory for changing the OAM properties of the title logos
	MOV		R1, #0
	SUB		R1, R1, #1
	MOV		R2, #0
	STR		R1, [R0], #4
	ADD		R2, R2, #1
	CMP		R2, #0x16
	ADDEQ	R0, R0, #0x44
	ADDEQ	R2, R2, #0x11
	CMP		R2, #0x29
	ADDEQ	R0, R0, #0x40
	ADDEQ	R2, R2, #0x10
	CMP		R2, #0x3D
	SUBCC	PC, PC, #0x2C
	LDR		R0, =0x20DB9F4
	ADD		R0, R0, #0xA4
	MOV		R2, #0
	MOV		R1, #0x2000
	CMP		R2, #4
	ADDGE	R1, R1, #0x40
	CMP		R2, #8
	SUBGE	R1, R1, #0x28
	ADD		R1, R1, #0xB8
	STR		R1, [R0], #8
	ADD		R2, R2, #1
	CMP		R2, #8
	SUBEQ	R0, R0, #0x68
	CMP		R2, #0xC
	SUBCC	PC, PC, #0x34
	LDR		R0, =0x20DB9F4
	ADD		R0, R0, #0xA6
	MOV		R1, #0x100
	ADD		R1, R1, #0x71
	MOV		R2, #0
	CMP		R2, #4
	ADDEQ	R1, R1, #0x100
	MOV		R1, R1, LSL #0x17
	MOV		R1, R1, LSR #0x17
	ORR		R1, R1, #0xC000
	STRH	R1, [R0], #8
	ADD		R1, R1, #0x40
	ADD		R2, R2, #1
	CMP		R2, #8
	SUBCC	PC, PC, #0x2C
	LDR		R0, =0x20DB9F4
	ADD		R0, R0, #0x7E
	MOV		R1, #0x100
	ADD		R1, R1, #0x88
	MOV		R2, #0
	MOV		R1, R1, LSL #0x17
	MOV		R1, R1, LSR #0x17
	ORR		R1, R1, #0xC000
	STRH	R1, [R0], #8
	ADD		R1, R1, #0x40
	ADD		R2, R2, #1
	CMP		R2, #4
	SUBCC	PC, PC, #0x24
	LDMFD	SP!, {PC}
	
ncp_call(0x020CDD88,9)
	LDR		R0, =0x20DB9F4
	ADD		R0, R0, #0xA8
	MOV		R1, #0
	LDR		R2, =0x2087710
	LDR		R2, [R2]
	MOV		R2, R2, LSR #7
	STR		R2, [R0], #8
	ADD		R2, R2, #0x20
	ADD		R1, R1, #1
	CMP		R1, #8
	SUBEQ	R0, R0, #0x68
	CMP		R1, #0xC
	SUBCC	PC, PC, #0x20
	LDR		R0, =0x778
	BX		LR