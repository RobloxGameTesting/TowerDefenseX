local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 120,
	Animated = true,
	AnimationName = "ClawEarthquake",
	AutoHandleEffects = true,
	Delay = 1.817,
	ExecutionTime = 7.717,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 45,
		TowerBuffNames = {
			Enums.TowerBuffs.ExoVoidClawEarthquakeFirerateDebuff,
			Enums.TowerBuffs.ExoVoidClawEarthquakeDamage
		}
	}
}