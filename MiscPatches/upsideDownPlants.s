@ Credit: Skawo
@ Upside-down Grounded Piranha Plants and Grounded Venus Fire Traps

@Rotate model if Nybble 11 set
ncp_call(0x0217A100,81)
ncp_call(0x0217AEFC,81)
        LDR     R0, [R4, #0x8]
        LSR     R0, #0x4
        ANDS    R0, #0xF
        LDREQH  R0, [R4,#0xC]
        BXEQ    LR
        MOV     R0, #0x8000
        STRH    R0, [R4, #0xA4]
        LDRH    R0, [R4,#0xC]
        BX      LR

@No gravity if Nybble 11 set
ncp_call(0x0217A3C0,81)
ncp_call(0x0217A2A4,81)
ncp_call(0x0217B074,81)
ncp_call(0x0217B17C,81)
ncp_call(0x0217B2AC,81)
        STMFD   SP!, {LR}
        LDR     R0, [R4, #0x8]
        LSR     R0, #0x4
        ANDS    R0, #0xF
        LDMNEFD SP!, {PC}
        MOV     R0, R4
        BL      0x209C85C
        LDMFD   SP!, {PC}

        
@Move stem hitbox if Nybble 11 set:
ncp_call(0x0217A178,81)
        LDR     R0, [R4, #0x8]
        LSR     R0, #0x4
        ANDS    R0, #0xF
        MOVEQ   R3, #0x0
        BXEQ    LR
        LDR     R0, =0x54C
        LDR     R1, =0xFFFF4000
        STR     R1, [R4, R0]
        MOV     R3, #0
        BX      LR              
        
@Move stem hitbox if Nybble 11 set:
ncp_call(0x0217AF60,81)
        LDR     R0, [R4, #0x8]
        LSR     R0, #0x4
        ANDS    R0, #0xF
        MOVEQ   R3, #0x0
        BXEQ    LR
        LDR     R0, =0x4BC
        LDR     R1, =0xFFFF3000
        STR     R1, [R4, R0]
        MOV     R3, #0
        BX      LR      