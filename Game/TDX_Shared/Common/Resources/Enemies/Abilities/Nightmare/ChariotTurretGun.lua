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
			DamageData = { Damage = 20 },
			TowerBuffNames = { Enums.TowerBuffs.ChariotTurretDebuff },
			Range = 20,
			ConsiderTargetsWithNoAttack = true,
			TargetMostExpensiveTower = true,
			TargetPathEntitiesIfNoTowers = true,
			HitVisualEffectName = Enums.VisualEffects.ExtraSmallBlast,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = { "Turret>Gun>GunVFX" }
}