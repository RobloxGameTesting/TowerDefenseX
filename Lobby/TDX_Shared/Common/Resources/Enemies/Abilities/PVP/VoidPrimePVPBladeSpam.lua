local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	CanTargetAir = false,
	ProjectileName = Enums.Projectiles.VoidPrimeSword,
	Range = 30,
	TargetGroundAroundEnemy = true,
	MinimumTargetsInRange = 1
}
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 3, Damage = 2500 },
	StartingCooldown = 5,
	Cooldown = 55,
	PrerequisiteAbilityName = Enums.EnemyAbilities.VoidPrimePVPRage,
	Animated = true,
	Delay = 64 / 60,
	ExecutionTime = 407 / 60,
	BurstSize = 12,
	BurstInterval = 0,
	ModelBurstSize = 2,
	CustomBurstDelayMap = {
		23 / 60,
		0.4,
		23 / 60,
		0.4,
		23 / 60,
		23 / 60,
		0.4,
		23 / 60,
		0.4,
		23 / 60,
		23 / 60
	},
	AnimationName = "BladeSpam",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = { v },
	InstantPlayEffectParentInstanceNames = { "BladeSpamSFX" }
}