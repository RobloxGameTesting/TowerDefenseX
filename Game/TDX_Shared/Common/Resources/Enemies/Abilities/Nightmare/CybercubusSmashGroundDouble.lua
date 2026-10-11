local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Animated = true,
	StartingCooldown = 5,
	StartingCooldownVariance = 2,
	Cooldown = 25,
	CooldownVariance = 0,
	Delay = 0.6,
	ExecutionTime = 134 / 75,
	AnimationName = "Smash Ground Double",
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 400 },
			TowerBuffNames = { Enums.TowerBuffs.CybercubusMediumFirerateDebuff },
			Range = 12
		}
	},
	EffectParentInstanceNames = {}
}