local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 4,
	Cooldown = 4,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	FaceTurretToTarget = true,
	TurretIndex = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			DamageData = { Damage = 1500 },
			Range = 30,
			MinimumRange = 4,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true,
			HitVisualEffectName = Enums.VisualEffects.EradidogRailgunBlast,
			HitVisualEffectVarianceXZ = 0.25,
			HitVisualEffectVarianceY = 0.15
		}
	},
	EffectParentInstanceNames = { "GunVFX1", "GunVFX2" }
}