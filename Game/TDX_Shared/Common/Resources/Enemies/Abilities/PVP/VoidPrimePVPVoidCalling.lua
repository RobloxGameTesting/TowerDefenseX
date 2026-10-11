local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	RequeryBeforeExecution = true,
	AffectTargetsWithNoAttack = true,
	TowerBuffNames = { Enums.TowerBuffs.VoidPrimeVoidCallingDebuff },
	TowerInstantKillData = {
		{ InstantKillType = "Void", Mechanical = true, AirPlacement = true }
	}
}
return {
	StartingCooldown = 3,
	Cooldown = 45,
	PrerequisiteAbilityName = Enums.EnemyAbilities.VoidPrimePVPRage,
	Animated = true,
	Delay = 16 / 3,
	ExecutionTime = 8.516666666666666,
	AnimationName = "VoidCalling",
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData,
	HealData = { ShieldGain = 100000, ShieldCap = 100000 },
	InstantPlayEffectParentInstanceNames = { "VoidCallingSFX" },
	EffectParentInstanceNames = { "VoidCallingVFX" },
	EffectsStartDelay = 7 / 3,
	EffectsStopDelay = 16 / 3
}