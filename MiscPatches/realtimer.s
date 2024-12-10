@ Credit: RicBent
@ Normally the timer ticks way faster than every 1 second. This patch fixes that and therefore makes the timer act like in New Super Luigi U.

ncp_call(0x020A2764,0)
        sub             r2, r2, #69
        bx              lr