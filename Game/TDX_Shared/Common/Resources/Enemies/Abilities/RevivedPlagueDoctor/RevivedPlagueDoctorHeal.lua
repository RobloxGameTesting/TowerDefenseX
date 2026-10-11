local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 12,
	Cooldown = 60,
	Animated = true,
	Delay = 13 / 15,
	ExecutionTime = 97 / 60,
	AnimationName = "Heal",
	EffectsStartDelay = 0.5,
	EffectsStopDelay = 1.6666666666666665,
	EffectParentInstanceNames = { "HealEffectPart" },
	HealData = { HealAmount = 10000 }
}