local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 55,
	Animated = true,
	Delay = 1.417,
	ExecutionTime = 6.567,
	BurstSize = 17,
	BurstInterval = 0,
	BurstTargetEntityUntilNotAlive = true,
	ClientBurstEffectsRespectCustomBurstDelayMap = true,
	CustomBurstDelayMap = {
		0.266,
		0.30000000000000004,
		0.2669999999999999,
		0.2669999999999999,
		0.266,
		0.2669999999999999,
		0.26700000000000035,
		0.2829999999999999,
		0.2669999999999999,
		0.28300000000000036,
		0.26699999999999946,
		0.266,
		0.2839999999999998,
		0.266,
		0.26700000000000035,
		0.26700000000000035
	},
	AnimationName = "PlasmaRifle",
	AutoHandleEffects = true,
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 1.1,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 1800 },
			CanTargetAir = true,
			NoTargetGround = true,
			Range = 35,
			MinimumRange = 8,
			TargetRandomTower = true,
			HitVisualEffectName = Enums.VisualEffects.ExoVoidPlasmaBlast,
			HitVisualEffectVarianceXZ = 0.15,
			HitVisualEffectVarianceY = 0.25
		}
	}
}