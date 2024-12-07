@ Credit: MeroMero

ncp_call(0x0209DC2C,0)
	LDRH	R0, [R4, #0xC]
	CMP		R0, #0x43
	ADDEQ	LR, LR, #4					@Prevent Star Coin freeze upon level completion if still in Collected animation…
	MOV		R0, #1						@… regardless of the influence of the NoFreeze patch
	BX		LR

ncp_call(0x021549F4,54)
	ADD		LR, LR, #4
	MOV		R1, #1
	STRH	R1, [R0, #0x14]
	LDR		R1, [R4, #8]
	AND		R1, R1, #0xF00
	MOV		R1, R1, LSR #0x8
	MOV		R0, R1, LSL #1
	LDR		R4, =StarCoinStack
	LDRB	R1, [R4]
	CMP		R0, #0
	MOVEQ	R0, #1
	ORR		R0, R1, R0
	STRB	R0, [R4]
	MOV		R1, #1
	BX		LR
	
ncp_call(0x02154A08,54)
	STMFD	SP!, {R3, R5, LR}
	LDR		R0, [R4, #8]
	AND		R0, R0, #0xF00
	MOV		R0, R0, LSR #0x8
	LDR		R1, =StarCoinStack
	LDRB	R3, [R1]
	LDRH	R5, [R2, #0x14]
	CMP		R0, #1
	BNE		.StarCoin3
	TST		R3, #1
	ADDNE	R5, R5, #1
	B		.Return
.StarCoin3:
	CMP		R0, #2
	BNE		.Return
	TST		R3, #1
	ADDNE	R5, R5, #1
	BNE		.Return
	TST		R3, #2
	ADDNE	R5, R5, #1
.Return:
	STRH	R5, [R2, #0x14]
	LDRH	R0, [R2, #0x14]
	LDMFD	SP!, {R3, R5, PC}
	
ncp_call(0x02154AFC,54)
	LDR		R0, [R4, #8]
	AND		R0, R0, #0xF00
	MOV		R0, R0, LSR #0x8
	LDR		R1, =StarCoinStack
	LDRB	R3, [R1]
	CMP		R0, #0
	BICEQ	R3, R3, #1
	CMP		R0, #1
	BICEQ	R3, R3, #2
	CMP		R0, #2
	BICEQ	R3, R3, #4
	STRB	R3, [R1]
	LDR		R1, =0x203C4BC
	STR		R1, [R4, #0x3F4]
	BX		LR
	
.data
.balign 1
StarCoinStack:
	.byte 0x0