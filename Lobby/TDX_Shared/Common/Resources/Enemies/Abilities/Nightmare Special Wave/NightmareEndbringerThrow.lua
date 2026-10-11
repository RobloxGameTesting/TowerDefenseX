local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 20000 },
	StartingCooldown = 5,
	Cooldown = 30,
	Delay = 1.5,
	ExecutionTime = 3.8,
	Animated = true,
	AnimationName = "Throw",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.NightmareEndbringerHammer,
			Range = 30,
			MinimumRange = 2,
			TargetRandomTower = true,
			TargetMinimumValue = 30000,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = {}
}