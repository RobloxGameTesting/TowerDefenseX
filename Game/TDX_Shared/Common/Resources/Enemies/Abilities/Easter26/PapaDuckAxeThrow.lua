local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2.5, Damage = 100 },
	StartingCooldown = 0,
	Cooldown = 6,
	CooldownVariance = 3,
	Animated = true,
	Delay = 0.5,
	ExecutionTime = 2.2,
	AnimationName = "Axe Throw",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.PapaDuckAxe,
			Range = 30,
			MinimumRange = 5,
			HitVisualEffectVarianceXZ = 0.1,
			HitVisualEffectVarianceY = 0,
			TowerBuffNames = { Enums.TowerBuffs.PapaDuckAxeThrowDebuff }
		}
	},
	EffectParentInstanceNames = {}
}