local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 4,
	Cooldown = 10,
	Animated = true,
	Delay = 0,
	ExecutionTime = 2.7,
	BurstSize = 17,
	BurstInterval = 0.15,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "Shoot",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.7,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 248 },
			Range = 15,
			TargetPathEntitiesOnly = true,
			HitVisualEffectName = Enums.VisualEffects.MinigunHit,
			HitVisualEffectVarianceXZ = 0.15,
			HitVisualEffectVarianceY = 0.25,
			TowerBuffNames = { Enums.TowerBuffs.E02DamageDebuff }
		}
	},
	EffectParentInstanceNames = { "Gun>Handle>Shoot" }
}