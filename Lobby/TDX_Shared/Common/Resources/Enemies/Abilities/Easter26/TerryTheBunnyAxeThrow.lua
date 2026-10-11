local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 3, Damage = 70 },
	StartingCooldown = 0,
	Cooldown = 10,
	Animated = true,
	Delay = 0.75,
	ExecutionTime = 2.15,
	AnimationName = "Axe Throw",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.TerryTheBunnyAxe,
			Range = 30,
			MinimumRange = 5,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	}
}