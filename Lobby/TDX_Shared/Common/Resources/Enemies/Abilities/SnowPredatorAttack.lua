local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 11,
	Cooldown = 15,
	Animated = true,
	Delay = 1.25,
	ExecutionTime = 2.25,
	AnimationName = "AttackSingle",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.SnowPredatorFreeze },
			DamageData = { Damage = 750 },
			Range = 17,
			TargetMostExpensiveTower = true,
			EffectParentInstanceName = "Shotgun Muzzle Effect",
			HitVisualEffectName = Enums.VisualEffects.PredatorShotgunBlast,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	}
}