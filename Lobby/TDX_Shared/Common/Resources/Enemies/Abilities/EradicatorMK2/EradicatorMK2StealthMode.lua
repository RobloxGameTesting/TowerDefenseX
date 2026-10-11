local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 35,
	Cooldown = 45,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	EffectParentInstanceNames = { "StealthVFX" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 1.25,
	HealData = { HealAmount = 42000 },
	GainStealthTime = 10
}