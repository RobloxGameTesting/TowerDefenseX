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
			DamageData = { Damage = 600, DamagePercentage = 0.04 },
			Range = 10,
			TargetMostExpensiveTower = true,
			EffectParentInstanceName = "Shotgun Muzzle Effect",
			HitVisualEffectName = Enums.VisualEffects.PredatorShotgunBlast,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	}
}