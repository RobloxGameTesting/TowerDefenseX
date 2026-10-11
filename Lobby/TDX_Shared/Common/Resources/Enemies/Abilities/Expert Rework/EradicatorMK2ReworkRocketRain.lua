local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	CanTargetAir = false,
	TargetGroundAroundEnemy = true,
	ProjectileName = Enums.Projectiles.EradicatorMK2ReworkMiniRocket,
	Range = 20,
	MinimumRange = 2,
	MinimumTargetsInRange = 3,
	ConsiderTargetsWithNoAttack = true,
	TargetRandomTower = true
}
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2.5,
		Damage = 300,
		DamagePercentage = 0.15
	},
	StartingCooldown = 8,
	Cooldown = 20,
	Animated = true,
	AnimationName = "RocketRain",
	Delay = 3.667,
	ExecutionTime = 7.433,
	FaceTarget = false,
	BurstSize = 72,
	BurstInterval = 0.0333333325,
	ModelBurstSize = 18,
	ParallelAbilityNames = { Enums.EnemyAbilities.EradicatorMK2ReworkRocketRain_Stomp },
	InstantPlayEffectParentInstanceNames = { "RocketRain>SFX" },
	EffectParentInstanceNames = { "RocketRain>SlamEffectPart" },
	EnemyToTowerRangedDataSequence = { v }
}