
/*********************
 Made by 
 * Will Smith
 * TheGameratorT 
 * IllyCat
*********************/

#include <nsmb.hpp>

#define DISABLE_SHOULDER_CAM_PAN false

static constexpr u8 TwirlLength = 15; 	// length of twirl in frames
static constexpr u8 TwirlCooldown = 15;	// frames after twirl until player can twirl again

// frames within TwirlCooldown that a shoulder press will be registered and saved for when the cooldown finishes
static constexpr u8 TwirlBuffer = 8; 

static constexpr u8 SfxStart = TwirlLength/3;

// sfx that plays SfxStart frames into the twirl
static constexpr s32 TwirlSFX = SeqArc::SAR_VS_COMMON_PLAYER_BASE::SE_PLY_QUAT;


struct TwirlState {
	bool twirling;
	bool bufferedTwirl;
	u8 twirlFrames;
	u8 twirlCooldown;
	fx16 startRotationY;
	fx32 startPosZ;
};

static TwirlState twirlState[2];


static void doMidairTwirl(Player* player) {
	TwirlState& ts = twirlState[player->playerID];

	// if groundpounding or no longer airborne end twirl early
	if (!player->subActionFlag.airborne) {
		if (player->physicsFlag.climbing) {
			player->rotation.y = (ts.startPosZ > 0 ? 180deg : 0);
		} else if (player->subActionFlag.groundPounding) {
			player->rotation.y = player->getDirectionalRotation(player->direction);
		}

		ts.twirlCooldown = 0;
		if (!player->actionFlag.wallSlide) 
			player->subActionFlag.fixDirection = false;
		ts.bufferedTwirl = false;
		ts.twirling = false;
		return;
	}

	if (ts.twirlFrames < TwirlLength) {
		if (ts.twirlFrames == SfxStart)
			Sound::playSFX(TwirlSFX, &player->position);

		ts.startRotationY += Math::cdeg(360/TwirlLength) * (player->direction ? -1 : 1);
		player->rotation.y = ts.startRotationY;

		if (player->velocity.y < 0) 
			player->velocity.y = 0;

		ts.twirlFrames++;
		
	} else if (ts.twirlCooldown) {
		if (!ts.bufferedTwirl && ts.twirlCooldown < TwirlBuffer && Input::playerKeysPressed[player->playerID] & Keys::Shoulder) {
			ts.bufferedTwirl = true;
		}
		ts.twirlCooldown--;
		if (ts.twirlCooldown == 0) 
			ts.twirling = false;

	} else {
		player->subActionFlag.fixDirection = false;
		ts.twirlCooldown = TwirlCooldown;
	}

}

static bool tryMidairTwirl(Player* player) {

	TwirlState& ts = twirlState[player->playerID];

	if (ts.bufferedTwirl && !player->subActionFlag.airborne) {
		ts.bufferedTwirl = false;
		return false;
	}

	if (player->subActionFlag.airborne &&
		!(player->actionFlag.flagpoleGrab || player->actionFlag.flagpoleSlide) &&
		!player->powerupSwitchStep && !Game::getPlayerDead(player->playerID) &&
		(Input::playerKeysPressed[player->playerID] & Keys::Shoulder || ts.bufferedTwirl)) {

		// make it so player can't turn around mid twirl
		player->subActionFlag.fixDirection = true; 

		ts.startPosZ = player->position.z;
		ts.startRotationY = player->rotation.y;
		ts.twirling = true;
		ts.twirlFrames = 0;
		ts.bufferedTwirl = false;
		if (!player->physicsFlag.lowHitbox) // if not crouching set animation
			player->setAnimation(6, true, Player::FrameMode::Restart, 1.1875fx, 0);

		doMidairTwirl(player);

		return true;
	} 

	return false;
}


ncp_hook(0x020fd1d4,10) // Player::onUpdate
static void customMovement(Player* player) { 

	TwirlState& ts = twirlState[player->playerID];

	if (!ts.twirling) 
		tryMidairTwirl(player);
	else
		doMidairTwirl(player);
};

#if DISABLE_SHOULDER_CAM_PAN
ncp_repl(0x020BA038, 0, "POP {R4-R8,PC}")
#endif
