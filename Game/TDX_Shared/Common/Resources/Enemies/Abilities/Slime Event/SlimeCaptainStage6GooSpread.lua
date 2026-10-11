local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 20,
	StartingCooldownVariance = 35,
	Animated = true,
	Delay = 4.3,
	ExecutionTime = 5.35,
	AnimationName = "GooSpread",
	EffectParentInstanceNames = { "GooSpread" },
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 8,
		MinimumTargets = 1,
		TowerBuffNames = { Enums.TowerBuffs.SlimeCaptainGooSpreadFirerateDebuff }
	}
}