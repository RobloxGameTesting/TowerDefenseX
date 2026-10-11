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
	Delay = 0.767,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	BurstSize = 3,
	BurstInterval = 1,
	CustomBurstDelayMap = { 1.416, 11.667 },
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MaximumRange = 1000,
		MinimumTargets = 0,
		AffectTargetsWithNoAttack = true,
		TowerBuffNames = { Enums.TowerBuffs.EradicatorMK2ReworkScreamStun }
	}
}