local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 4,
	StartingCooldownVariance = 3,
	Cooldown = 18,
	CooldownVariance = 5,
	Animated = true,
	Delay = 7 / 6,
	ExecutionTime = 2.55,
	AnimationName = "Fire",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 50 },
			Range = 24,
			HitVisualEffectName = Enums.VisualEffects.PredatorShotgunBlast,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "FXPart" }
}