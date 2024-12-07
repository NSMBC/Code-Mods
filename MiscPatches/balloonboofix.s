@ Credit: MeroMero

ncp_call(0x02175F08,71)
	LDRB	R0, [R5, #8]
	CMP		R0, #0x10			@Check if byte 4 of main Actor Data is less than 16
	ADDCC	PC, PC, #0x28		@If true then load R1 and return
	TST		R0, #1				@Check R0 parity
	MOVEQ	R0, #0x2000			@If even then make Balloon Boo big
	MOVNE	R0, #0x1000			@If odd then make Balloon Boo small
	MOV		R1, #0x12			@R1=18
	MUL		R1, R0, R1			@Multiply by 18 to get the hitbox value
	STR		R0, [R5, #0xF0]		@Store Balloon Boo new length
	STR		R0, [R5, #0xF4]		@Store Balloon Boo new height
	STR		R0, [R5, #0xF8]		@Store Balloon Boo new width
	STR		R1, [R5, #0x4EC]	@Store Balloon Boo new Hitbox Vertical Shifting
	STR		R1, [R5, #0x4F0]	@Store Balloon Boo new Hitbox length
	STR		R1, [R5, #0x4F4]	@Store Balloon Boo new Hitbox height
	LDRB	R1, [R5, #0x2BD]
	BX		LR