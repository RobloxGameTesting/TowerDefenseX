local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 150,
	Animated = true,
	Delay = 1.2,
	ExecutionTime = 4.3,
	AnimationName = "Smoke Heal",
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 12,
		TowerBuffNames = { Enums.TowerBuffs.EngineerNightmareToxicCloudDebuff }
	},
	EnemyToEnemyRadiusEffectData = {
		DoNotUseForTriggering = true,
		MaximumRange = 12,
		EnemyBuffNames = { Enums.EnemyBuffs.EngineerNightmareToxicCloudBuff }
	},
	EffectParentInstanceNames = { "AttachmentHelper_Gun>GasVFX", "RootPart>GasSFX" },
	EffectsStartDelay = 0.9
}