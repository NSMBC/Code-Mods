@ Credit: MeroMero

ncp_call(0x02165024,54)
	LDR		R0, [R4, #8]
	ANDS	R0, R0, #0x80			@Check Liquid direction
	ADDEQ	R1, R1, R2				@If up add R2 to get final position
	SUBNE	R1, R1, R2				@If down subtract R2 to get final position
	MOV		R0, #0x1000
	ADD		LR, LR, #4
	BX		LR