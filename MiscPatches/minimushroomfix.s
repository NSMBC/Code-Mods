@ Credit: MeroMero

ncp_call(0x020D1628,10)				@From Block
ncp_call(0x020D3F0C,10)				@From Item Inventory
	AND		R1, R5, #0x1F
	CMP		R1, #0x19
	LDREQ	R3, =BottomCollision
	LDREQ	R1, =SideCollision
	STREQ	R1, [SP]
	MOV		R1, R4
	BX		LR
	
.data
.balign 4
BottomCollision:
	.word 0x0
	.word 0x0
	.word 0x8000
	.word 0x0
	.word 0x0
	.word 0x18000

.balign 4
SideCollision:
	.word 0x1
	.word 0x1000
	.word 0x7000
	.word 0x4000