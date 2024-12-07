@ Credit: MeroMero

ncp_call(0x0215418C,54)
	ADD		LR, LR, #4
	BX		LR
	
ncp_call(0x021541A0,54)
	ADD		LR, LR, #0x10
	LDR		R5, [R4, #8]
	CMP		R0, #1						@Check if Super Mario
	ANDEQ	R5, R5, #0x30000000			@Stage 2 power-up (nybble 4)
	ANDNE	R5, R5, #0x1000000			@Stage 3 power-up (nybble 5)
	MOV		R5, R5, LSR #0x18
	MOVEQ	R5, R5, LSR #4
	ADDNE	R5, R5, #4
	ADD		R5, R5, #1
	CMP		R5, #6
	BNE		.Return
	CMP		R0, #3
	MOVEQ	R5, #5
.Return:
	CMP		R5, #5
	ADDCC	LR, LR, #0xC
	BX		LR
	
ncp_call(0x021541C8,54)
	LDR		R0, =PowerUpTable
	BX		LR
	
ncp_call(0x021541D0,54)
	MOV		R5, R5, LSL #1
	LDRH	R1, [R0, R5]
	BX		LR
	
.data
.balign 2
PowerUpTable:
	.hword 0x1088	@Red Mushroom
	.hword 0x1089	@Fire Flower
	.hword 0x1099	@Mini Mushroom
	.hword 0x108B	@Blue Shell
	.hword 0x1089	@Fire Flower
	.hword 0x1087	@1-Up Mushroom
	.hword 0x1081	@Starman