ncp_call(0x02154e74, 54)
ncp_call(0x021548b4, 54)
    LDR        R0, =0x02088BFC
    LDR        R0, [R0]
    CMP        R0, #1    @world number
    LDREQ           R0, =MODEL ID - 0x83
    BXEQ            LR
    LDR             R0, =0x4e9
    BX              LR
    
ncp_call(0x02154e68, 54)
ncp_call(0x021548e0, 54)
    LDR        R0, =0x02088BFC
    LDR        R0, [R0]
    CMP        R0, #1    @worldnumber
    LDREQ           R0, =MODEL ID - 0x83
    BXEQ            LR
    LDR             R0, =0x4c2
    BX              LR
