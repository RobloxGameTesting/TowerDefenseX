local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0.3,
	Cooldown = 0.3,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	FaceTurretToTarget = true,
	TurretIndex = 1,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 10 },
			Range = 80,
			MinimumRange = 2,
			ConsiderTargetsWithNoAttack = true,
			TargetMostExpensiveTower = true,
			HitVisualEffectName = Enums.VisualEffects.ExtraSmallBlast,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "GunVFX" }
}