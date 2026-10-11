local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 0,
	Animated = false,
	ExecutionTime = 0,
	CanRunInParallel = true,
	Delay = 3.666,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			DamageData = { Damage = 500 },
			TowerBuffNames = { Enums.TowerBuffs.VoidWardenDeathFirerateDebuff },
			Range = 12,
			HitAllTargetsInRange = true
		}
	}
}