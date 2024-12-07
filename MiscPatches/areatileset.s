@ Credit: MeroMero

ncp_call(0x020AF9C4,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder
	LDMFD	SP!, {PC}
	
ncp_call(0x020BD088,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder
	ADD		R0, R0, #1
	LDMFD	SP!, {PC}
	
ncp_call(0x020B84EC,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder2
	ADD		R2, R0, #2
	LDR		R0, =0x7A5
	LDMFD	SP!, {PC}
	
ncp_call(0x020B8518,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder2
	ADD		R0, R0, #2
	LDMFD	SP!, {PC}
	
ncp_call(0x020BCFF4,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder
	ADD		R0, R0, #3
	LDMFD	SP!, {PC}
	
ncp_call(0x020BCC78,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder
	ADD		R0, R0, #4
	LDMFD	SP!, {PC}
	
ncp_call(0x020BCD4C,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder
	ADD		R0, R0, #5
	LDMFD	SP!, {PC}
	
ncp_call(0x020BCCE8,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder
	ADD		R0, R0, #6
	LDMFD	SP!, {PC}
	
ncp_call(0x020BC904,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder2
	ADD		R8, R0, #7
	LDMFD	SP!, {PC}
	
ncp_call(0x020BCA50,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder2
	ADD		R8, R0, #8
	LDMFD	SP!, {PC}
	
ncp_call(0x020BB9B0,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder
	ADD		R0, R0, #9
	LDMFD	SP!, {PC}
	
ncp_call(0x020B3A60,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder2
	ADD		R0, R0, #0xA
	LDMFD	SP!, {PC}
	
ncp_call(0x020B3A3C,0)
	STMFD	SP!, {LR}
	BL		.VisualCourseFolder
	ADD		R0, R0, #0xB
	LDMFD	SP!, {PC}
	
.VisualCourseFolder:
	STMFD	SP!, {LR}
	LDR		R1, =0x2085A94
	LDRH	R1, [R1]
	MOV		R0, #0xC
	MUL		R1, R0, R1
	LDR		R0, =0x7A6
	ADD		R0, R0, R1
	LDR		R1, =0x7A5
	LDMFD	SP!, {PC}
	
.VisualCourseFolder2:
	STMFD	SP!, {R1, LR}
	LDR		R1, =0x2085A94
	LDRH	R1, [R1]
	MOV		R0, #0xC
	MUL		R1, R0, R1
	LDR		R0, =0x7A6
	ADD		R0, R0, R1
	LDMFD	SP!, {R1, PC}