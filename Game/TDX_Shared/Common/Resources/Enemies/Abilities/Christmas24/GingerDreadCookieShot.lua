local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2.5, Damage = 2000 },
	StartingCooldown = 15,
	Cooldown = 60,
	Animated = true,
	Delay = 1.5,
	ExecutionTime = 2.267,
	AnimationName = "CookieShot",
	SecondaryAnimationForKeyframeEventsName = "Damaged_CookieShot",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.Cookie,
			Range = 40,
			MinimumRange = 5,
			TargetRandomTower = true,
			TargetMinimumValue = 1500,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = {}
}