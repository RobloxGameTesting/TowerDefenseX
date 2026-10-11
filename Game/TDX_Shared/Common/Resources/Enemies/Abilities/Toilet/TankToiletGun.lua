local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 6,
	Cooldown = 6,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	FaceTurretToTarget = true,
	TurretIndex = 1,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 400 },
			Range = 50,
			MinimumRange = 4,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true,
			HitVisualEffectName = Enums.VisualEffects.Blast125mm,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "GunVFX" }
}