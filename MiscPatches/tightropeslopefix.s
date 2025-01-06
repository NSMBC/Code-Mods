@ Hex edit patch by MeroMero ported to asm by Will Smith
@ WARNING: I don't trust this

ncp_jump(0x20a9af0,0) @ CollisionMgr::updatePlayerHorizontal
	bne 	0x20a9af0 + 4 		@ if PlatformMgr::update returns false, skip
	strb 	r0, [r5, #0x7f]		@ clear upper 8 bits of collisionResult
	b    	0x20a9ba8
