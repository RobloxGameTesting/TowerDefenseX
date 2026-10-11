local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 8,
		BuffName = Enums.TowerBuffs.EradicatorMK4BurnDebuff
	},
	StartingCooldown = 8,
	Cooldown = 40,
	Animated = true,
	Delay = 1.566,
	ExecutionTime = 3.433,
	BurstSize = 2,
	BurstInterval = 0.30000000000000004,
	AnimationName = "LegGrenadesFire",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.EradicatorMK4GrenadeYellow,
			Range = 28,
			MinimumRange = 12,
			TargetRandomTower = true,
			TargetMinimumValue = 1500
		}
	},
	EffectParentInstanceNames = { "LegGrenadeEffectsPart" }
}