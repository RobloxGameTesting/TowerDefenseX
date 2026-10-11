local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 0,
	Cooldown = 0,
	Animated = true,
	Delay = 5 / 3,
	ExecutionTime = 2.92,
	AnimationName = "Armor Break",
	ParallelAbilityNames = { Enums.EnemyAbilities.CybercubusArmorBreak_Invulnerable },
	EffectParentInstanceNames = { "ArmorBreakFXPart" },
	EffectsStartDelay = 5 / 3,
	MaximumUses = 1,
	TriggeredAtHealthPercentage = 0.6,
	HealData = { HealAmount = 50000 }
}