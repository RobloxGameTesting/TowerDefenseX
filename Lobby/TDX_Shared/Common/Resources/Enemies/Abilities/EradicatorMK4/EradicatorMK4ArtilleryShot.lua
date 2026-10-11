local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 7,
		DamageFalloffRanges = {
			{ Range = 0, Damage = 6250 },
			{ Range = 80, Damage = 12000 },
			{ Range = 150, Damage = 20000 },
			{ Range = 175, Damage = 70000 },
			{ Range = 300, Damage = 100000 }
		}
	},
	StartingCooldown = 5,
	Cooldown = 30,
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