local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 20,
	Cooldown = 14,
	Animated = true,
	Delay = 2.833,
	ExecutionTime = 12.667,
	BurstSize = 20,
	BurstInterval = 0.4,
	AnimationName = "Barrage",
	FaceTarget = true,
	EffectParentInstanceNames = { "Barrage" },
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = {
				Damage = 2000,
				DamageFalloffRanges = {
					{ Range = 9, Damage = 1500 },
					{ Range = 22, Damage = 1000 }
				}
			},
			Range = 22,
			MinimumRange = 10,
			TargetMostExpensiveTower = true,
			HitVisualEffectName = Enums.VisualEffects.PredatorShotgunBlast,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	}
}