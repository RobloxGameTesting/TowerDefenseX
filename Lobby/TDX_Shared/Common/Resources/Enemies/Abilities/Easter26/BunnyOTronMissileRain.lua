local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 10,
		Damage = 350,
		BuffName = Enums.TowerBuffs.BunnyOTronMissileRainDebuff
	},
	StartingCooldown = 4,
	Cooldown = 38,
	Animated = true,
	AnimationName = "RocketRain",
	Delay = 3,
	ExecutionTime = 4.85,
	FaceTarget = false,
	BurstSize = 2,
	BurstInterval = 0,
	InstantPlayEffectParentInstanceNames = { "RootPart>RocketRain" },
	EffectParentInstanceNames = {},
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.BunnyOTronMissile,
			Range = 50,
			MinimumRange = 0,
			MinimumTargetsInRange = 2,
			TargetMostExpensiveTower = true,
			TryGetUniqueTargetForEachBurst = true
		}
	}
}