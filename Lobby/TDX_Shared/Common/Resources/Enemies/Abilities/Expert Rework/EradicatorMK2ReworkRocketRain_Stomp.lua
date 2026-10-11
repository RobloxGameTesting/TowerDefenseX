local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 2.85,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MaximumRange = 18,
		MinimumTargets = 0,
		AffectTargetsWithNoAttack = true,
		TowerBuffNames = { Enums.TowerBuffs.EradicatorMK2ReworkRocketRainStompStun }
	}
}