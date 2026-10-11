local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2.5,
		BuffName = Enums.TowerBuffs.NightmareSlimeKingSwordDebuff
	},
	StartingCooldown = 5,
	Cooldown = 40,
	Animated = true,
	AnimationName = "SwordThrow",
	Delay = 1.317,
	ExecutionTime = 4.8,
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.NightmareSlimeKingSword,
			Range = 50,
			MinimumRange = 5,
			TargetMostExpensiveTower = true,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	}
}