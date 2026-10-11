local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 6,
	StartingCooldownVariance = 2,
	CooldownVariance = 2,
	Animated = true,
	Delay = 0.167,
	ExecutionTime = 2.1999999999999997,
	ContinueMovingWhileUsing = true,
	AnimationName = "Attack",
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.RavageDamageDebuff, Enums.TowerBuffs.RavageStunDebuff },
			Range = 4.5,
			HitAllTargetsInRange = true
		}
	},
	ContinuouslyExecuteRangedDataSequence = true
}