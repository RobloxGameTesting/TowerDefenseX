local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 8.5,
		DamageFalloffRanges = {
			{ Range = 0, Damage = 25000 },
			{ Range = 80, Damage = 35000 },
			{ Range = 150, Damage = 45000 },
			{ Range = 175, Damage = 100000 },
			{ Range = 300, Damage = 200000 }
		}
	},
	StartingCooldown = 0,
	Cooldown = 5,
	Animated = true,
	Delay = 2.4,
	ExecutionTime = 4.267,
	AnimationName = "ArtilleryFire",
	FaceTarget = true,
	FaceTargetAngleOffset = -0.10471975511965978,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.EradicatorMK4Shell,
			Range = 2000,
			MinimumRange = 40,
			TargetHighestRangeTower = true,
			TargetMinimumValue = 100000,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "ArtilleryShot", "ChestHitPart" }
}