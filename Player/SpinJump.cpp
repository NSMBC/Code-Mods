#include "nsmb.hpp"

struct TwirlState {
	bool twirling;
	u8 twirlFrames;
	u8 twirlCooldown;
	fx16 startRotationY;
};

static TwirlState twirlState[2];

static void doMidairTwirl(Player* player) {
	TwirlState& ts = twirlState[player->playerID];
	
	if (ts.twirlFrames < 15) {
		if (ts.twirlFrames == 5) {
			Sound::playSFX(345,&player->position);
		}

		if (player->direction) ts.startRotationY -= 0x1100;
		else ts.startRotationY += 0x1100;
		player->rotation.y = ts.startRotationY;


		if (player->velocity.y < 0) player->velocity.y = 0;

		ts.twirlFrames++;

	} else if (ts.twirlCooldown) {
		ts.twirlCooldown--;
		if (ts.twirlCooldown == 0) ts.twirling = false;

	} else {
		player->subActionFlag &= ~0x400; // remove fixed direction flag
		ts.twirlCooldown = 15;
	}

}

static bool tryMidairTwirl(Player* player) {
	if ((player->subActionFlag & 0x40) && 	// airborne flag
		!(player->actionFlag & 0x4000) && 	// flagpole slide flag
		(Input::playerKeysPressed[player->playerID] & Keys::Shoulder) &&
		!player->powerupSwitchStep) {

		// add fixed direction flag so player can't turn around mid twirl
		// I find it looks weird when you turn around mid-twirl; personal preference
		player->subActionFlag |= 0x400; 

		TwirlState& ts = twirlState[player->playerID];

		ts.startRotationY = player->rotation.y;
		ts.twirling = true;
		ts.twirlFrames = 0;
		if (!(player->physicsFlag & 4)) // if not crouching set animation to in air
			player->setAnimation(0x6, true,Player::FrameMode::Restart,0x1300,0);

		doMidairTwirl(player);

		return true;
	} 

	return false;
}


ncp_hook(0x020fd1d4,10) // Player::onUpdate
static void customMovement(Player* player) { 
	TwirlState& ts = twirlState[player->playerID];

	if (!ts.twirling) {
		tryMidairTwirl(player);
	} else {
		doMidairTwirl(player);
	}

};