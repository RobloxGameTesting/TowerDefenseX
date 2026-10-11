local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 20,
	Cooldown = 10,
	Animated = true,
	Delay = 23 / 12,
	ExecutionTime = 47 / 6,
	AnimationName = "Tremor",
	EffectParentInstanceNames = { "SlamGroundFXPart" },
	EffectsStartDelay = 23 / 12,
	EffectsStopDelay = 407 / 60,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 25,
		TowerBuffNames = { Enums.TowerBuffs.Smasher9xFirerateDebuff }
	}
}