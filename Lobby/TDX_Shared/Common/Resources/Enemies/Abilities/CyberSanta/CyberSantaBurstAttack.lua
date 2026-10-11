local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 4,
	Cooldown = 12,
	Animated = true,
	Delay = 1.4,
	ExecutionTime = 68 / 15,
	BurstSize = 3,
	BurstInterval = 0.855,
	AnimationName = "Triple Shot",
	EffectParentInstanceNames = { "SingleShotVFX1", "SingleShotVFX2", "SingleShotSFX" },
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 275 },
			TowerBuffNames = { Enums.TowerBuffs.CyberSantaTripleShotStun },
			Range = 22,
			MinimumRange = 3,
			TargetMostExpensiveTower = true,
			HitVisualEffectName = Enums.VisualEffects.PredatorShotgunBlast,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	}
}