ncp_call(0x02165a38, 54)
ncp_call(0x02165b9c, 54)
	LDR R0, =0x02088BFC
	LDR R0, [R0]
	CMP R0, #7 @world id
	LDREQ R0, =File Id - 0x83
	BXEQ LR
	LDR R0, =0x617
	BX LR