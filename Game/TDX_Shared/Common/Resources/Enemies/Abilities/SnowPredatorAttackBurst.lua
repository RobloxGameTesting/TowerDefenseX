local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 12,
	Animated = true,
	Delay = 1.26,
	ExecutionTime = 3.55,
	BurstSize = 3,
	BurstInterval = 0.6,
	AnimationName = "AttackBurst",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.SnowPredatorFreeze },
			DamageData = { Damage = 275 },
			Range = 22,
			MinimumRange = 5,
			TargetRandomTower = true,
			EffectParentInstanceName = "Shotgun Muzzle Effect",
			HitVisualEffectName = Enums.VisualEffects.PredatorShotgunBlast,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	}
}