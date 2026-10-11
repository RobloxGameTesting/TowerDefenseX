local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Animated = true,
	StartingCooldown = 25,
	StartingCooldownVariance = 2,
	Cooldown = 30,
	CooldownVariance = 0,
	Delay = 11 / 15,
	ExecutionTime = 139 / 75,
	AnimationName = "Smash Ground Single",
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 1000 },
			TowerBuffNames = { Enums.TowerBuffs.CybercubusLargeFirerateDebuff },
			Range = 12
		}
	},
	EffectParentInstanceNames = { "SlamFXPart" }
}