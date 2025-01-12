@ Credit: Skawo
@ https://nsmbhd.net/thread/3530-ghost-star-coin/

@Always spawn
ncp_call(0x02154690,54)
	LDR R2, [R5,#8]
	LSR R2, R2, #28
	AND R2, R2, #0xF
	CMP R2, #1
	MOVEQ R2, #0
	LDRNEB R2, [R0]

@Don't ever look collected
ncp_call(0x02154678,54)
	CMP R0, #0
	BXEQ LR
	LDR R0, [R5, #8]
	LSR R0,R0,#28
	AND R0, R0, #0xF
	CMP R0, #1
	MOVEQ R0, #0
	BX LR

@Spin counterclockwise
ncp_call(0x02154B78,54)
	LDR R0, [R4, #8]
	LSR R0,R0,#28
	AND R0, R0, #0xF
	CMP R0, #1
	LDR R0,=0x0212945C
	LDRSH R0, [R0,#0x6]
	RSBEQ R0,#0x1
	BX LR

@Don't count towards level completion
ncp_call(0x02154C54,54)
	MOV R4, R0
	LDR R0, [R4, #8]
	LSR R0,R0,#28
	AND R0, R0, #0xF
	CMP R0, #1
	BEQ 0x02154CA8
	BXNE LR

@Play Boo Laugh
ncp_call(0x02154CA8,54) 
	LDR R0, [R4, #8] 
	LSR R0,R0,#28 
	AND R0, R0, #0xF 
	CMP R0, #0 
	LDREQ R0, =0x123
	LDRNE R0, =0xA2
	ADD R1, R4, #0x5C 
	BX LR

@Particle 1 replacement
ncp_call(0x02154D08,54)
	LDR R0, [R4, #8]
	LSR R0,R0,#28
	AND R0, R0, #0xF
	CMP R0, #1
	LDRNE R0, =0xF8
	LDREQ R0, =0x1D
	BX LR

@Particle 2 replacement
ncp_call(0x02154D28,54)
	LDR R0, [R4, #8]
	LSR R0,R0,#28
	AND R0, R0, #0xF
	CMP R0, #1
	LDRNE R0, =0xF9
	LDREQ R0, =0xFA
	BX LR

@Particle 3 replacement
ncp_call(0x02154D34,54)
	LDR R0, [R4, #8]
	LSR R0,R0,#28
	AND R0, R0, #0xF
	CMP R0, #1
	LDRNE R0, =0xFA
	LDREQ R0, =0x6B 
	BX LR

@Destroy itself
ncp_call(0x02154D3C,54)
	LDR R0, [R4,#0x508]
	CMP R0, #0
	BXNE LR
	LDR R0, [R4, #8]
	LSR R0,R0,#28
	AND R0, R0, #0xF
	CMP R0, #1
	MOVLT R0, #0
	BX LR