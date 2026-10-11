local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 60,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	PrerequisiteAbilityName = Enums.EnemyAbilities.EradicatorMK2ReworkRage,
	EffectParentInstanceNames = { "StealthMode" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 1.25,
	HealData = { HealAmount = 175000 },
	GainStealthTime = 10
}