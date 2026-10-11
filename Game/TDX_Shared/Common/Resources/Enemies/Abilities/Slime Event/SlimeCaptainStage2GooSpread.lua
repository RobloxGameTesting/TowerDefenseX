local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 20,
	StartingCooldownVariance = 3,
	Animated = true,
	Delay = 4.183,
	ExecutionTime = 5.633,
	AnimationName = "GooSpread",
	EffectParentInstanceNames = { "GooSpread" },
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 8,
		MinimumTargets = 1,
		TowerBuffNames = { Enums.TowerBuffs.SlimeCaptainGooSpreadFirerateDebuff }
	}
}