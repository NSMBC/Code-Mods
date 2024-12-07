@ Credit: MeroMero

@Force the game to reload the Area even when switching Views within the same Area
@Beneficial side effect: prevents a graphical glitch for FG Effects upon View Change within the same Area
ncp_call(0x0215E4AC,54)
	BX		LR
	
ncp_jump(0x0211963C,10)
	B		0x2119664
	
@No matter the Area, do NOT nuke Event IDs until Mario exits the level!
ncp_call(0x0201DEA8)
ncp_call(0x0201DEAC)
ncp_call(0x0201DF00)
ncp_call(0x0201DF04)
ncp_call(0x0201DF34)
	BX		LR

@Set Entrance ID to go to
ncp_call(0x0201E99C)
	LDR		R12, =0x20CA8FF
	LDRB	R8, [R4, #0xC]				@Get Destination Entrance
	STRB	R8, [R12]					@Set Placeholder Destination Entrance
	LDRH	R8, [R4, #2]
	BX		LR

@Set Entrance ID from Warp
ncp_call(0x021564D0,54)
	LDR		R1, =0x20CA8FF
	LDRB	R0, [R5, #0x410]
	STRB	R0, [R1]
	LDRB	R0, [R5, #0x410]
	BX		LR

@Set Entrance ID from Clogged Pipe
ncp_call(0x021732C0,59)
	LDR		R1, =0x20CA8FF
	LDRB	R0, [R5, #0x4B7]
	STRB	R0, [R1]
	LDRB	R0, [R5, #0x4B7]
	BX		LR

@Set Entrance ID from Event Door
ncp_call(0x0218CAF8,118)
	LDR		R1, =0x20CA8FF
	AND		R4, R5, #0xFF
	STRB	R4, [R1]
	MOV		R1, R5, LSR #8
	BX		LR

@Reload Tileset, Foreground, Background, Sounds Set and Actors Set
ncp_call(0x0201FB6C)
	LDR		R0, =0x20CA8FF
	LDR		R4, =0x208589C
	LDR		R4, [R4]
	CMP		R4, #0						@Check if level (not area) is loading
	BEQ		.LevelAlreadyLoaded			@If already loaded jump to next function
	MOV		R4, #0						@Fetch Start Entrance
	LDR		R6, =0x2085A30
	LDRB	R6, [R6]					@Get Midway flag
	CMP		R6, #0xFF
	MOVNE	R4, #1						@If Midway flag is set, fetch Midway Entrance instead
	LDR		R1, [R5]
	ADD		R1, R5, R1
	LDRB	R6, [R1, R4]
	STRB	R6, [R0]					@Store Entrance ID
.LevelAlreadyLoaded:
	LDRB	R0, [R0]
	ADD		R4, R5, #0x28
	LDR		R1, [R4]
	ADD		R1, R5, R1					@Get beginning offset
	LDR		R4, [R4, #4]
	ADD		R4, R1, R4					@Get end offset
	MOV		R7, #0						@Set default View Number at 0
.LoopViewNumber:
	LDRB	R6, [R1, #8]				@Get Entrance ID
	CMP		R6, R0						@Compare Entrance ID with the placeholder Entrance ID
	LDREQB	R7, [R1, #0x12]				@If both IDs match get View Number
	BEQ		.SuccessViewNumber
	ADD		R1, R1, #0x14				@Go to next Entrance Data
	CMP		R1, R4						@Compare current offset to end offset
	BCC		.LoopViewNumber				@Continue looping until end offset becomes the lesser one
.SuccessViewNumber:
	MOV		R0, #0						@Set counter for LoopLoadFromView
	CMP		R7, #0						@Compare View Number to 0
	BEQ		.Return						@If true then Return
	MOV		R1, R5
	LDR		R6, [R5, #-0xC]				@Get filesize
	ADD		R6, R5, R6					@Get end of file offset
.LoopLoadFromView:
	MOV		R4, R1
	LDR		R1, [R4, #0x68]
	ADD		R1, R5, R1
	ADD		R1, R1, #0x10
	CMP		R1, R6
	BCS		.Return						@If greater or equal then Return, this will consider the default View Number
	ADD		R0, R0, #1
	CMP		R0, R7						@Compare counter to View Number
	BCC		.LoopLoadFromView			@Exit the loop if greater or equal (most likely equal)
	MOV		R4, R5
	MOV		R6, #0
.LoopWriteForView:
	LDR		R0, [R1], #4				@Fetch offsets and sizes for each of the 14 blocks for selected View Number
	STR		R0, [R4], #4				@Write them to the beginning of the file, where they are supposed to be read
	ADD		R6, R6, #1
	CMP		R6, #0x1C					@14 blocks, 8 bytes, maximum of 4 bytes per register
	BCC		.LoopWriteForView			@Hence why the loop is broken at 28 and not 14
.Return:
	LDR		R4, =0x208B168				@Default instruction that was replaced to allow this mod
	BX		LR
	
@Reload Music if necessary
ncp_call(0x0201E790)
	ADD		LR, LR, #0xC
	BIC		R1, R1, #0x80
	LDR		R0, [SP]
	CMP		R0, #0
	BLT		.GetView
	CMP		R0, #4
	BGE		.GetView
	LDR		R2, =0x2085A3C
	LDR		R2, [R2]
	CMP		R0, R2
	BEQ		.GetView
	CMP		R1, #0x70
	BXCC	LR
.GetView:
	STMFD	SP!, {R3-R4}
	LDR		R4, =0x20CA8FF
	LDRB	R4, [R4]
	LDR		R0, =0x2086A2C
	LDR		R0, [R0]
	LDR		R2, [R0, #0x28]
	ADD		R2, R0, R2
	LDR		R3, [R0, #0x2C]
	ADD		R3, R2, R3
.LoopGetView:
	LDRB	R0, [R2, #0x8]
	CMP		R0, R4
	BEQ		.OutLoopGetView
	ADD		R2, R2, #0x14
	CMP		R2, R3
	BCC		.LoopGetView
.OutLoopGetView:
	LDRB	R0, [R2, #0x12]				@Get View Number
	LDR		R4, =0x2086A2C
	LDR		R4, [R4]
	LDR		R3, [R4, #0x38]
	ADD		R3, R4, R3
	LDR		R4, [R4, #0x3C]
	ADD		R4, R4, R3
.LoopGetView2:
	LDRB	R2, [R3, #0x8]
	CMP		R2, R0
	BEQ		.OutLoopGetView2
	ADD		R3, R3, #0x10
	CMP		R3, R4
	BCC		.LoopGetView2
.OutLoopGetView2:
	LDRB	R1, [R3, #0xA]
	BIC		R1, R1, #0x80
	LDMFD	SP!, {R3-R4}
	BX		LR