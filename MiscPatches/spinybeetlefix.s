@ Credit: MeroMero

ncp_call(0x0214F62C,42)
	MOV		R1, #1
	STR		R1, [R0]
	MOV		R1, #0x2000
	STR		R1, [R0, #4]
	MOV		R1, #0xA000
	STR		R1, [R0, #8]
	LDR		R1, [R0]
	BX		LR
	
ncp_call(0x0214F358,42)
	MOV		R2, #0x6000
	BX		LR
	
ncp_call(0x021775B8,68)
	LDR		R0, =0x598				@Increase heap for Buzzy Beetle
	BX		LR
	
ncp_call(0x02176574,68)
	MOV		R5, LR
	ADD		LR, R4, #0x500
	ADD		LR, LR, #0x84			@Actor Address for Buzzy Beetle Side Collision
	STR		LR, [SP]
	BX		R5
	
ncp_call(0x021765B8,68)
	MOV		R12, #0x6000
	STR		R12, [R4, #0x590]
	LDR		R12, =0x2178F98
	LDR		R6, [R12]
	STR		R6, [R4, #0x584]
	LDR		R6, [R12, #4]
	STR		R6, [R4, #0x588]
	LDR		R12, [R12, #8]
	STR		R12, [R4, #0x58C]
	BX		LR
	
ncp_call(0x02176594,68)
	MOV		R6, #1
	STR		R6, [R12]
	MOV		R6, #0x3000
	STR		R6, [R12, #4]
	MOV		R6, #0xB000
	STR		R6, [R12, #8]
	LDR		R6, [R12]
	BX		LR
	
ncp_call(0x02176B5C,68)
	LDR		R1, [R4, #0x584]
	BIC		R1, R1, #0x2700000
	STR		R1, [R4, #0x584]
	BX		LR
	
ncp_call(0x02176B9C,68)
	LDR		R2, [R4, #0x584]
	ORR		R2, R2, #0x2700000
	STR		R2, [R4, #0x584]
	BX		LR
	
ncp_call(0x02176D58,68)
	LDR		R1, [R4, #0x584]
	BIC		R1, R1, #0x2700000
	STR		R1, [R4, #0x584]
	ADD		R3, R3, #0x14
	BX		LR
	
ncp_call(0x02176E40,68)
	LDR		R1, [R4, #0x584]
	ORR		R1, R1, #0x2400000
	STR		R1, [R4, #0x584]
	ADD		R3, R3, #0x14
	BX		LR
	
ncp_call(0x02176E90,68)
	LDR		R1, [R4, #0x584]
	ORR		R1, R1, #0x2700000
	STR		R1, [R4, #0x584]
	ADD		R3, R3, #0x14
	ADD		R2, R4, #0x500
	ADD		R2, R2, #0x64
	BX		LR
	
ncp_call(0x020A919C,0)
	LDR		R4, [R5, #4]
	LDRH	R4, [R4, #0xC]
	CMP		R4, #0x28
	BEQ		.SuccessSpinyCheck
	CMP		R4, #0x7B
	BNE		.BuzzyBeetleCheck
.SuccessSpinyCheck:
	LDRB	R4, [R2, #0x1B]
	CMP		R4, #0x10
	MOVNE	R4, #0x2000
	MOVEQ	R4, #0x5000
	STR		R4, [R2, #0x3BC]
	ORR		R4, R0, #0
	BX		LR
.BuzzyBeetleCheck:
	CMP		R4, #0x36
	BNE		.Return
	LDRB	R4, [R2, #0x1B]
	CMP		R4, #0x10
	MOVNE	R4, #0x3000
	MOVEQ	R4, #0x5000
	STR		R4, [R2, #0x338]
.Return:
	ORR		R4, R0, #0
	BX		LR