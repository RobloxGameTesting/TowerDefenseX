local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 15,
	Animated = true,
	Delay = 2.45,
	ExecutionTime = 3.167,
	AnimationName = "Attack",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 2800 },
			Range = 60,
			TargetMostExpensiveTower = true,
			EffectParentInstanceName = "RightShootEffect",
			EffectsStartDelay = 2.6,
			HitVisualEffectName = Enums.VisualEffects.PredatorShotgunBlast,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "LeftShootEffect" }
}