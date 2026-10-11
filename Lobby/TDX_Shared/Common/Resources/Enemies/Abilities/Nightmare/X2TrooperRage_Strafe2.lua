local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	Delay = 15.75,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	BurstSize = 20,
	BurstInterval = 0.08,
	BurstTargetEntityUntilNotAlive = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 1500 },
			Range = 150,
			TargetRandomTower = true,
			TargetMinimumValue = 10000,
			HitVisualEffectName = Enums.VisualEffects.MinigunHit,
			HitVisualEffectVarianceXZ = 0.15,
			HitVisualEffectVarianceY = 0.25
		}
	}
}