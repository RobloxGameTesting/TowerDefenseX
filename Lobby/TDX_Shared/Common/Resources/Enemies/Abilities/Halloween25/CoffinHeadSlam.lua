local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 9,
	Cooldown = 18,
	Delay = 32 / 15,
	ExecutionTime = 5.7,
	Animated = true,
	AnimationName = "Slam",
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 150 },
			TowerBuffNames = { Enums.TowerBuffs.CoffinHeadDebuff },
			Range = 17,
			HitAllTargetsInRange = true
		}
	},
	EffectParentInstanceNames = { "SlamFXPart" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SlamFX" }
}