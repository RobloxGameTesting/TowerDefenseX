local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("ProjectileTypes"))
return {
	StartingCooldown = 25,
	Cooldown = 22,
	Animated = true,
	Delay = 1.5,
	ExecutionTime = 2.85,
	BurstSize = 2,
	BurstInterval = 0.5,
	BurstNoRetargetIfTargetNotAlive = true,
	BurstTargetEntityUntilNotAlive = true,
	ProjectileHitData = { IsSplash = false, Damage = 50000 },
	AnimationName = "Railgun Fire",
	FaceTarget = true,
	ForceFaceOverideTimeInitial = 1.25,
	ForceFaceOverideTime = 2,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.RailgunProjectile,
			MinimumRange = 15,
			Range = 60,
			TargetMostExpensiveTower = true,
			HitVisualEffectVarianceXZ = 0.15,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = {}
}