local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0.75,
	Cooldown = 2,
	StartingCooldownVariance = 0.5,
	Animated = false,
	CanRunInParallel = true,
	Delay = 0,
	ExecutionTime = 0,
	EffectParentInstanceNames = { "HumanoidRootPart>Heal" },
	EnemyToEnemyRadiusEffectData = {
		MaximumRange = 7,
		HealData = { ShieldGain = 1000, ShieldGainPercentageOfTargetMaxHealth = 0.05 }
	},
	AffectedEntityEffectData = { EffectName = Enums.VisualEffects.ShieldGainVFX }
}