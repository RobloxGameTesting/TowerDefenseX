local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 80,
	Animated = true,
	Delay = 1.2,
	ExecutionTime = 4.3,
	AnimationName = "Smoke Heal",
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 12,
		TowerBuffNames = { Enums.TowerBuffs.EngineerToxicCloudDebuff }
	},
	EnemyToEnemyRadiusEffectData = {
		DoNotUseForTriggering = true,
		MaximumRange = 12,
		EnemyBuffNames = { Enums.EnemyBuffs.EngineerToxicCloudBuff }
	},
	EffectParentInstanceNames = { "AttachmentHelper_Gun>GasVFX", "RootPart>GasSFX" },
	EffectsStartDelay = 0.9
}