@ Credit: MeroMero

ncp_call(0x021111DC,10)
	STMFD	SP!, {R6-R7}
	ADD		R7, PC, #0x164
	ADD		LR, PC, #0
	BX		R7
	CMP		R1, R6
	ADDLT	PC, PC, #0x14
	CMP		R0, #0
	MOVLT	R0, R6
	RSBLT	R0, R0, #0
	MOVGE	R0, R6
	LDMFD	SP!, {R6-R7}
	B		0x21111F4
	LDMFD	SP!, {R6-R7}
	B		0x21111FC

ncp_call(0x021114D8,10)
	STMFD	SP!, {R6-R7}
	LDR		R6, =0x203A784
	LDR		R6, [R6]
	LDR		R6, [R6, #0x2F8]
	LDR		R6, [R6, #0x7B0]
	TST		R6, #0x80
	MOVEQ	R0, #0
	ADDNE	R0, R0, #0x80
	CMP		R0, #0
	ADDNE	PC, PC, #4
	LDMFD	SP!, {R6-R7}
	B		0x21114E0
	ADD		R7, PC, #0x100
	ADD		LR, PC, #0
	BX		R7
	LDR		R7, =0x203A784
	LDR		R7, [R7]
	LDR		R7, [R7, #0x2F8]
	LDR		R1, [R7, #0xC4]
	LDR		R2, [R7, #0xC8]
	CMP		R1, R2
	MOVEQ	R1, #1
	MOVNE	R1, #0
	CMP		R2, #0
	RSBLT	R6, R6, #0
	CMP		R1, #0
	STRNE	R6, [R7, #0xC4]
	STR		R6, [R7, #0xC8]
	LDMFD	SP!, {R6-R7}
	B		0x2111528
	
ncp_call(0x0211162C,10)
	TST		R2, #0x80			@Check if +Down is pressed
	ADDNE	R0, R0, #0x80
	CMP		R0, #0
	BNE		0x2111634
	B		0x211169C
	
ncp_call(0x02111874,10)
	STMFD	SP!, {R6-R7}
	ADD		R7, PC, #0xA0
	ADD		LR, PC, #0
	BX		R7
	MOV		R1, R6
	LDMFD	SP!, {R6-R7}
	B		0x2111878
	
ncp_call(0x021122E8,10)
	STMFD	SP!, {R6-R7}
	ADD		R7, PC, #0x84
	ADD		LR, PC, #0
	BX		R7
	CMP		R0, #0
	MOVLT	R0, R6
	RSBLT	R0, R0, #0
	MOVGE	R0, R6
	LDMFD	SP!, {R6-R7}
	B		0x21122F8
	
ncp_call(0x02112574,10)
	STMFD	SP!, {R6-R7}
	ADD		R7, PC, #0x5C
	ADD		LR, PC, #0
	BX		R7
	CMP		R0, #0
	MOVLT	R0, R6
	RSBLT	R0, R0, #0
	MOVGE	R0, R6
	LDMFD	SP!, {R6-R7}
	B		0x2112584
	
ncp_call(0x02115D14,10)
	STMFD	SP!, {R6-R7}
	ADD		R7, PC, #0x34
	ADD		LR, PC, #0
	BX		R7
	CMP		R0, R6
	ADDGE	PC, PC, #4
	LDMFD	SP!, {R6-R7}
	B		0x2115D40
	LDMFD	SP!, {R6-R7}
	LDR		R0, =0x203A784
	LDR		R0, [R0]
	LDR		R0, [R0, #0x2F8]
	LDR		R0, [R0, #0x7B0]
	TST		R0, #0x80
	BNE		0x2115D18
	B		0x2115D40
	
@relative function
	STMFD	SP!, {LR}
	LDR		R6, =0x203A784
	LDR		R7, =0x208B350		@Pointer for Starman duration counter
	LDR		R7, [R7]			@Get Starman remaining time
	CMP		R7, #0				@Check if Starman counter is 0
	MOVNE	R7, #4
	LDR		R6, [R6]
	LDR		R6, [R6, #0x2F8]
	LDR		R6, [R6, #0x264]	@Get Mario's current action
	CMP		R6, #0				@Check if Mario is airborne
	MOVEQ	R7, #0
	LDR		R6, =0x212E344		@Pointer for running speed
	LDR		R6, [R6, R7]		@Get max speed
	LDMFD	SP!, {PC}