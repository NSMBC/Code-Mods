#include <nsmb/game/stage/actors/ov32/pipepiranha.hpp>

#if SCALABLE
#include <nsmb/core/graphics/particle.hpp>
#endif

#if MORE_HEALTH
#include <nsmb/game/sound/sound.hpp>
#include <nsmb/game/sound/seqarcdef.hpp>
#endif

/**************************/
// HEAP EXTENSION
static constexpr SizeT PipePiranhaSize = sizeof(PipePiranha);

ncp_over(0x2143838,32)
static const SizeT piranhaUpSize = PipePiranhaSize;

ncp_over(0x21437d0,32)
static const SizeT piranhaDownSize = PipePiranhaSize;

ncp_over(0x2143768,32)
static const SizeT piranhaRightSize = PipePiranhaSize;

ncp_over(0x2143700,32)
static const SizeT piranhaLeftSize = PipePiranhaSize;
/**************************/

ncp_call(0x21427a8,32) // PipePiranha::onCreate
static void piranhaInitAC(ActiveCollider* ppAC, PipePiranha* pp, const AcConfig& acCfg, u8 layerID) {

	PipePiranha::Settings settings = pp->getSettings();
	
	ppAC->init(pp,acCfg,layerID);
	
	#if MORE_HEALTH
	pp->fireballHits = 0;

	if (settings.invincible)
		ppAC->config.attack |= AcAttack::EntityAsWeapon;

	#endif
	
	#if SCALABLE
	u8 scale = settings.scale;

	if (scale > 1) {
		pp->activeSize.set(32*scale,52*scale);
		pp->renderSize.set(32*scale,52*scale);
	}
	#endif

}

ncp_call(0x21427c8,32) // PipePiranha::onCreate
static void piranhaInitStemAC(ActiveCollider* stemAC, PipePiranha* pp, const AcConfig& acCfg, u8 layerID) {

	stemAC->init(pp,acCfg,layerID);

	#if MORE_HEALTH
	if (pp->getSettings().invincible)
		stemAC->config.attack |= AcAttack::EntityAsWeapon;
	#endif

}

#if SCALABLE

ncp_call(0x2142fcc,32) // PipePiranha::leavePipeState
static void piranhaLeavePipeUpdate(PipePiranha* pp) {

	u8 scale = pp->getSettings().scale;

	if (scale > 1) {
		fx32 n = 1.0fx - Math::div(Fx32::cast(pp->transitCooldown), Fx32::cast(PipePiranha::PipeTransitLength));
		fx32 curScale = Math::lerpFx(2.0fx,Fx32::cast(scale),n);
		fx32 acScale = Math::lerpFx(8.0fx,8.0fx*scale,n);

		pp->activeCollider.config.rect = {0, acScale, acScale, acScale};
		pp->scale.set(curScale);

		if (pp->pipeDirection < 2) {
			pp->stemCollider.config.rect.y = acScale;
			pp->stemCollider.config.rect.halfHeight = acScale;
		} else {
			pp->stemCollider.config.rect.x = acScale;
			pp->stemCollider.config.rect.halfWidth = acScale;
		}
	}

	pp->applyVelocity(); // replaced call
}

ncp_call(0x2142a70,32) // PipePiranha::enterPipeState
static void piranhaEnterPipeUpdate(PipePiranha* pp) {

	u8 scale = pp->getSettings().scale;

	if (scale > 1) {
		fx32 n = 1.0fx - Math::div(Fx32::cast(pp->transitCooldown), Fx32::cast(PipePiranha::PipeTransitLength));
		fx32 curScale = Math::lerpFx(Fx32::cast(scale),2.0fx,n);
		fx32 acScale = Math::lerpFx(8.0fx*scale,8.0fx,n);

		pp->activeCollider.config.rect = {0, acScale, acScale, acScale};
		pp->scale.set(curScale);

		if (pp->pipeDirection < 2) {
			pp->stemCollider.config.rect.y = acScale;
			pp->stemCollider.config.rect.halfHeight = acScale;
		} else {
			pp->stemCollider.config.rect.x = acScale;
			pp->stemCollider.config.rect.halfWidth = acScale;
		}

	}

	pp->applyVelocity(); // replaced call
}

ncp_call(0x21428e8,32) // PipePiranha::defeatedState
static void defeatedSmokePuffHook(const Vec3& pos) {
	NTR_REGISTER(PipePiranha*, pp, r4);

	if (pp->getSettings().scale <= 2)
		Particle::Handler::createSmokePuff(pos);
	else
		Particle::Handler::createBigSmokePuff(pos); // bigger smoke puff for bigger piranha

}

#endif // SCALABLE


#if MORE_HEALTH

static void fireballHitHook(PipePiranha* pp) {

	if (pp->getSettings().invincible)
		return;

	pp->fireballHits++;
	pp->cooldownA = PipePiranha::DamagedEffectLength;

	// TODO: where and why does this get reset?????
 	if ((pp->properties & EntityProperties::NoFireball) != EntityProperties::None)
	 	pp->properties &= ~EntityProperties::NoFireball;

	if (pp->fireballHits >= pp->getSettings().health) {
		rcast<void(*)(PipePiranha*)>(0x214239c)(pp); // original onFireballHit
	} else {
		SND::playSFX(SeqArc::SAR_PLAYER_BASE::SE_OBJ_FIREBALL_DISAPP, &pp->position);
		SND::playSFX(SeqArc::SAR_ENEMY_BASE::SE_EMY_PAKKUN_DAMAGE, &pp->position);
	}
}

ncp_over(0x2143aac,32) // PipePiranha::vtable
static const auto onFireballHitVFunc = fireballHitHook;

#if ALLOW_CODE_PACK
// size: 24 bytes
ncp_over(0x2142030,32)
#endif
static void entityHitHook(PipePiranha* pp) {
	if (!pp->getSettings().invincible)
		rcast<void(*)(PipePiranha*)>(0x21422d4)(pp); // original onEntityHit
}

ncp_over(0x2143aa8,32) // PipePiranha::vtable
static const auto onEntityHitVFunc = entityHitHook;

// leaves 148 free bytes at 0x2141fd8!!
ncp_jump(0x2141fd4,32) // PipePiranha::spawnCoin
static void spawnCoinReplace(PipePiranha* pp) {

	static constexpr u8 MaxCoinDrop = 10;
	const u8 numCoins = Math::clamp(pp->getSettings().health, 1, MaxCoinDrop);

	for (u8 i = 0; i < numCoins; i++) {

		const Vec3 spawnPos = {pp->exitPosition.x, pp->exitPosition.y, 128.0fx};

		if (numCoins > 1) {
			Actor* coin = Actor::spawnActor(66, 3, &spawnPos); // scatter coins randomly, like big ground piranha does

		} else {
			Actor* coin = Actor::spawnActor(66, 5, &spawnPos);
			if (coin != nullptr) {
				coin->position.x -= 8.0fx;
				coin->velocity.x = PipePiranha::coinVelocitiesX[pp->pipeDirection];
				coin->velocity.y = PipePiranha::coinVelocitiesY[pp->pipeDirection];
			}
		}
	}
}

ncp_call(0x2142544,32) // PipePiranha::onRender
static void renderHook(Model* mdl, const VecFx32* scale) {
	NTR_REGISTER(PipePiranha*, pp, r4);

	pp->applyFireballWiggle();

	if (pp->cooldownA == 0) {
		mdl->render(scale);
	} else {
		NNS_G3dMdlSetMdlFogEnableFlagAll(mdl->data,TRUE);
		mdl->render(&pp->wiggleScale);
		NNS_G3dMdlSetMdlFogEnableFlagAll(mdl->data,FALSE);
	}
}

#endif // MORE_HEALTH

#if TIMING_OPTIONS

#if ALLOW_CODE_PACK
// size: 16 bytes
ncp_over(0x2142048,32) // 20 free bytes now at 0x2142058!!
#endif
NTR_USED static bool noPlayerWaitCheck(PipePiranha* pp) {
	return pp->getSettings().noPlayerWait;
}

ncp_jump(0x2143254,32) // PipePiranha::waitState
NTR_NAKED static void waitStateHook() {asm(R"(
	mov 	r0, r4
	bl 		_ZL17noPlayerWaitCheckP11PipePiranha
	cmp 	r0, #1
	beq 	0x214326c 		@ if noPlayerWait, skip player distance checks and switch to leavePipeState
	cmp 	r1, #0 			@ otherwise, keep replaced instruction
	b 		0x2143254 + 4 	@ branch back
)");}

// size: 88 bytes
#if ALLOW_CODE_PACK
ncp_over(0x2141fd8,32)
#endif
static void switchStateSetTransitHook(PipePiranha* pp, PipePiranha::StateFunction nextState) {

	PipePiranha::Speed speed = pp->getSettings().attackLength;

	if (speed != PipePiranha::Speed::Normal) {
		pp->transitCooldown = Math::mul(pp->transitCooldown, PipePiranha::SpeedMultiplier[scast<u32>(speed)]);
	}

	// pp->switchState(nextState); // symbol address in the reference is currently wrong!
	rcast<void(*)(PipePiranha*,PipePiranha::StateFunction)>(0x0214353C)(pp,nextState);
}
ncp_set_call(0x2143094,32,switchStateSetTransitHook) // PipePiranha::leavePipeState
ncp_set_call(0x2142b24,32,switchStateSetTransitHook) // PipePiranha::enterPipeState
ncp_set_call(0x2142b6c,32,switchStateSetTransitHook) // PipePiranha::enterPipeState


NTR_USED static s16 getMoveTransitLength(PipePiranha* pp) {

	s16 ret = PipePiranha::PipeTransitLength;
	
	PipePiranha::Speed speed = pp->getSettings().moveSpeed;
	fx32 speedMult = PipePiranha::SpeedMultiplier[scast<u32>(speed)];

	if (speed != PipePiranha::Speed::Normal) {
		ret = Fx32(Math::div(Fx32::cast(ret), speedMult)).whole();

		if (pp->pipeDirection < 2) { 							// vertical facing piranhas
			fx32 velY = Math::mul(pp->velocity.y, speedMult);
			pp->velocity.y = velY; 
			pp->targetVelocity.y = velY;
		} else {  												// horizontal facing
			fx32 velX = Math::mul(pp->velocity.x, speedMult);
			pp->velocity.x = velX;
			pp->targetVelocity.x = velX;
		}

		pp->model.setSpeed(pp->model.frameController.speed > 0 ? speedMult : -speedMult);

	}

	return ret;

}

ncp_jump(0x2142a28,32) // PipePiranha::enterPipeState
NTR_NAKED static void enterPipeStateInitHook() {asm(R"(
	mov 	r0, r4
	bl 		_ZL20getMoveTransitLengthP11PipePiranha
	mov 	r1, r0
	add 	r0, r4, #0x500 	@ keep replaced instruction
	b 		0x2142a28 + 8 	@ branch back
)");}

ncp_jump(0x2142f7c,32) // PipePiranha::leavePipeState
NTR_NAKED static void leavePipeStateInitHook() {asm(R"(
	mov 	r0, r4 	@ keep replaced instruction
	bl 		_ZL20getMoveTransitLengthP11PipePiranha
	mov 	r2, r0
	mov 	r0, r4
	add 	r1, r4,#0x500
	b 		0x2142f7c + 12
)");}

#endif // TIMING_OPTIONS
