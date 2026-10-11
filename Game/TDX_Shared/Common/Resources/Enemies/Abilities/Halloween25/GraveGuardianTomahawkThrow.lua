local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 1,
		Damage = 1,
		BuffName = Enums.TowerBuffs.GraveGuardianTomahawkThrowDebuff
	},
	StartingCooldown = 5,
	Cooldown = 8,
	Animated = true,
	Delay = 71 / 60,
	ExecutionTime = 119 / 60,
	AnimationName = "Tomahawk Throw",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.GraveGuardianTomahawk,
			Range = 30,
			MinimumRange = 5,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	}
}