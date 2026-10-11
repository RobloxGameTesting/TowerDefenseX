local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	RequeryBeforeExecution = true,
	MaximumRange = 18,
	TowerBuffNames = { Enums.TowerBuffs.HarvestWitchFirerateDebuff }
}
return {
	StartingCooldown = 12,
	Cooldown = 35,
	Animated = true,
	Delay = 14 / 3,
	ExecutionTime = 5.8,
	AnimationName = "Spell",
	EffectsStartDelay = 1.25,
	EffectsStopDelay = 14 / 3,
	EffectParentInstanceNames = { "Channeling", "RootPart>VFX" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX" },
	EnemyToEnemyRadiusEffectData = {
		RequeryBeforeExecution = true,
		NoAffectSelf = true,
		MaximumRange = 18,
		HealData = { ShieldGain = 12000 },
		EnemyBuffNames = { Enums.EnemyBuffs.HarvestWitchSpeedBuff }
	},
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData
}