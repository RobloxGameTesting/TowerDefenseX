local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 18,
	Animated = true,
	Delay = 1,
	ExecutionTime = 1.8,
	AnimationName = "Stun",
	EnemyToTowerRadiusEffectData = {
		MinimumTargets = 1,
		MaximumTargets = 5,
		MaximumRange = 10,
		TowerBuffNames = { Enums.TowerBuffs.CurseVineStunDebuff }
	},
	InstantPlayEffectParentInstanceNames = { "Root>FX" }
}