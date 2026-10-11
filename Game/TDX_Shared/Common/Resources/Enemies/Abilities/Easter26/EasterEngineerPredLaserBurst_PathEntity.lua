local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	CanTargetAir = true,
	ProjectileName = Enums.Projectiles.EasterEngineerPredLaserProjectile,
	Range = 60,
	MinimumRange = 10,
	TargetPathEntitiesOnly = true,
	PathEntityInitialQueryReduceRange = 3,
	HitVisualEffectVarianceXZ = 0.5,
	HitVisualEffectVarianceY = 0.25
}
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3,
		Damage = 15000,
		DamagePercentage = 0.8
	},
	StartingCooldown = 13,
	Cooldown = 75,
	Animated = true,
	Delay = 1.5,
	ExecutionTime = 3.133,
	BurstSize = 5,
	BurstInterval = 0.85,
	CustomBurstDelayMap = {
		0.16700000000000004,
		0.11599999999999988,
		0.06700000000000017,
		0.04999999999999982
	},
	PrerequisiteAbilityName = Enums.EnemyAbilities.EasterEngineerArm_Predator,
	AnimationName = "PredLaserBurst",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = { v },
	EffectParentInstanceNames = {},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>PredLaserBurst" }
}