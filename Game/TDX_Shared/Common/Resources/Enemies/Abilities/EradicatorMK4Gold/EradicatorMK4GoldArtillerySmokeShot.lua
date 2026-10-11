local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 12,
		BuffName = Enums.TowerBuffs.EradicatorMK4GoldSmokeDebuff
	},
	StartingCooldown = 10,
	Cooldown = 30,
	Animated = true,
	Delay = 2.4,
	ExecutionTime = 4.267,
	AnimationName = "ArtilleryShotSmoke",
	FaceTarget = true,
	FaceTargetAngleOffset = -0.10471975511965978,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.EradicatorMK4SmokeShell,
			Range = 600,
			MinimumRange = 40,
			TargetHighestRangeTower = true,
			TargetMinimumValue = 10000,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "ArtillerySmokeShot", "ChestHitPart" }
}