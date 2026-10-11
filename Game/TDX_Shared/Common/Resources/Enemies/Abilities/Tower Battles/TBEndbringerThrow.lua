local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 9999999 },
	StartingCooldown = 5,
	Cooldown = 30,
	Animated = true,
	Delay = 0,
	ExecutionTime = 4.167,
	AnimationName = "Throw",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.TBEndbringerHammer,
			Range = 30,
			MinimumRange = 2,
			TargetMostExpensiveTower = true,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = {}
}