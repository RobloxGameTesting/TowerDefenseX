local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	CanTargetAir = true,
	TowerBuffNames = { Enums.TowerBuffs.VoidPrimeEmpBladeDebuff },
	DamageData = { Damage = 1800 },
	Range = 12,
	HitAllTargetsInRange = true
}
return {
	StartingCooldown = 5,
	Cooldown = 60,
	PrerequisiteAbilityName = Enums.EnemyAbilities.VoidPrimeRage,
	Animated = true,
	Delay = 13 / 15,
	ExecutionTime = 3.166666666666667,
	AnimationName = "EmpBlade",
	EnemyToTowerRangedDataSequence = { v },
	InstantPlayEffectParentInstanceNames = { "EmpBladeSFX" },
	EffectParentInstanceNames = { "EmpBladeVFX" },
	EffectsStartDelay = 13 / 15,
	EffectsStopDelay = 5
}