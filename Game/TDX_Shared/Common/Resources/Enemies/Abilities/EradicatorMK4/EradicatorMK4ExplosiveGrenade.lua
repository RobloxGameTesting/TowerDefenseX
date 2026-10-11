local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 7, Damage = 1250 },
	StartingCooldown = 12,
	Cooldown = 40,
	Animated = true,
	Delay = 2.5,
	ExecutionTime = 3.666,
	BurstSize = 2,
	BurstInterval = 0.2,
	AnimationName = "ChestGrenadesExplosive",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.EradicatorMK4GrenadeRed,
			Range = 28,
			MinimumRange = 12,
			TargetRandomTower = true,
			TargetMinimumValue = 1500
		}
	},
	EffectParentInstanceNames = { "ChestGrenadeEffectsPart" }
}