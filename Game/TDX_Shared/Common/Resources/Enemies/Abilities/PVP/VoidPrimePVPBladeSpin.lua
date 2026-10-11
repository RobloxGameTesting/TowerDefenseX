local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TowerBuffNames = { Enums.TowerBuffs.VoidPrimeBladeSpinDamage, Enums.TowerBuffs.VoidPrimeBladeSpinVulnerable },
	Range = 20,
	HitAllTargetsInRange = true
}
local v2 = {
	TowerBuffNames = { Enums.TowerBuffs.VoidPrimeBladeSpinSlamStun },
	DamageData = { Damage = 2200 },
	Range = 20,
	HitAllTargetsInRange = true,
	EffectParentInstanceName = "StompVFX"
}
return {
	StartingCooldown = 5,
	Cooldown = 45,
	PrerequisiteAbilityName = Enums.EnemyAbilities.VoidPrimePVPRage,
	Animated = true,
	Delay = 1,
	ExecutionTime = 391 / 60,
	BurstSize = 2,
	BurstInterval = 53 / 12,
	AnimationName = "BladeSpin",
	EnemyToTowerRangedDataSequence = { v, v2 },
	InstantPlayEffectParentInstanceNames = { "BladeSpinSFX" }
}