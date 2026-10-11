local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 0,
	Animated = false,
	CanRunInParallel = true,
	Delay = 0,
	ExecutionTime = 0,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			TowerBuffNames = { Enums.TowerBuffs.DisruptorDeathDebuff },
			Range = 16,
			HitAllTargetsInRange = true
		}
	}
}