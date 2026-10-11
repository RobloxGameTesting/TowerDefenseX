local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 12,
	Animated = true,
	Delay = 7 / 3,
	ExecutionTime = 3.366666666666667,
	AnimationName = "AntiAir",
	FaceTarget = true,
	EffectParentInstanceNames = { "AntiAir" },
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
			DamageData = {
				Damage = 1250,
				DamageFalloffRanges = {
					{ Range = 10, Damage = 800 },
					{ Range = 22, Damage = 700 }
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