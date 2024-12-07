@ Credit: MeroMero

ncp_call(0x020A2758,0)
	STMFD	SP!, {R1-R4, LR}
	LDR		R1, =0x208B35C
	LDR		R1, [R1]
	LDRB	R1, [R1, #0x2BE]
	LDR		R4, =0x2086A2C
	LDR		R4, [R4]
	LDR		R2, [R4, #0x38]
	ADD		R2, R4, R2
	LDR		R3, [R4, #0x3C]
	ADD		R3, R2, R3
.LoopGetView:
	LDRB	R4, [R2, #0x8]
	CMP		R4, R1
	BEQ		.OutLoopGetView
	ADD		R2, R2, #0x10
	CMP		R2, R3
	BCC		.LoopGetView
.OutLoopGetView:
	LDRB	R1, [R2, #0xA]
	LDRB	R2, [R0]
	TST		R1, #0x80
	ORRNE	R2, R2, #0x40
	BICEQ	R2, R2, #0x40
	STRB	R2, [R0]
	LDRB	R0, [R0]
	LDMFD	SP!, {R1-R4, PC}
	
ncp_call(0x0201E07C)
	LDRNEB	R0, [R0, #0xA]
	BIC		R0, R0, #0x80
	BX		LR

ncp_call(0x0201FCC0)
	BIC		R0, R0, #0x80
	STRB	R0, [R5]
	BX		LR