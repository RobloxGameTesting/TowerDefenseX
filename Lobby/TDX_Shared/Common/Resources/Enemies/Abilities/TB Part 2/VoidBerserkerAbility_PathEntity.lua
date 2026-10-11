local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 15,
	Animated = false,
	ExecutionTime = 0,
	CanRunInParallel = true,
	DoNotTryToUse = true,
	Delay = 0.9,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 18,
		AffectPathEntitiesOnly = true,
		TowerBuffNames = {
			Enums.TowerBuffs.VoidBerserkerShockStun,
			Enums.TowerBuffs.VoidBerserkerShockDamagePathEntities
		}
	}
}