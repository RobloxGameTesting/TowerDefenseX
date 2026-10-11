local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 30,
	Animated = true,
	Delay = 1.8,
	ExecutionTime = 3.1830000000000003,
	AnimationName = "Stomp",
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.VoidPrimeStompStun },
			DamageData = { Damage = 500 },
			Range = 20,
			HitAllTargetsInRange = true
		}
	},
	InstantPlayEffectParentInstanceNames = { "StompSFX" },
	EffectParentInstanceNames = { "StompVFX" }
}