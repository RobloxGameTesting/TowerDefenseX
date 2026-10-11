local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 12,
	Cooldown = 12,
	StartingCooldownVariance = 5,
	CooldownVariance = 5,
	Animated = true,
	Delay = 0.65,
	ExecutionTime = 2.9669999999999996,
	AnimationName = "Bark",
	EffectParentInstanceNames = { "RageModeSmoke" },
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.EradidogBarkDebuff },
			Range = 12,
			HitAllTargetsInRange = true
		}
	}
}