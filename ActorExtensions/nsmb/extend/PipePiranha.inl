// This file is *inlined* inside the actual body of the class
// Here you can add anything to it, declarations can be put in a separate .cpp source

// You cannot include headers nor do forward declarations!
// You still have to hook into the constructor to increase the heap allocation size!

/**************************/
// OPTIONS
#define SCALABLE 		true
#define MORE_HEALTH 	true
#define TIMING_OPTIONS 	true

#define ALLOW_CODE_PACK false 	// if true, we can (where possible) try to pack new code into areas renderered obsolete
								// if using, be sure to compile with -Os!!
/**************************/
// MEMBERS
#if MORE_HEALTH
u8 fireballHits;
#endif

/**************************/
// SETTINGS

#if TIMING_OPTIONS
enum class Speed : u8 {
	Normal,
	VerySlow,
	MediumSlow,
	Slow,
	Fast,
	MediumFast,
	VeryFast,

	Count
};

static constexpr fx32 SpeedMultiplier[scast<u8>(Speed::Count)] = {1.0fx, 0.25fx, 0.375fx, 0.5fx, 2.0fx, 3.0fx, 4.0fx};
#endif

#if SCALABLE || TIMING_OPTIONS
static constexpr u32 PipeTransitLength = 32;
#endif

#if MORE_HEALTH
static constexpr u8 DamagedEffectLength = 8;
#endif

struct Settings : StrongBitFlag<u32> {

	/**** RESERVED *****/
	u8 fireballs 		: 8;	/* 41-48 */
	/*******************/

	#if SCALABLE
	u8 scale 			: 4;	/* 37-40 */
	#endif

	#if MORE_HEALTH
	u8 health 			: 4;	/* 33-36 */
	bool invincible 	: 1;	/* 32 */
	#endif

	#if TIMING_OPTIONS
	bool noPlayerWait 	: 1;	/* 31 */
	Speed attackLength	: 3;	/* 28-30 */
	Speed moveSpeed		: 3;	/* 25-27 */
	#endif

	// u16 free 			: 8;

};
NTR_SIZE_GUARD(Settings, sizeof(u32));

/**************************/
// FUNCTIONS
NTR_INLINE Settings getSettings() {
	return Settings(settings);
}
