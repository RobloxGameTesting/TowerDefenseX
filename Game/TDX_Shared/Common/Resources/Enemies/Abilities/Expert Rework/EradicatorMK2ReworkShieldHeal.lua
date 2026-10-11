local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 25,
	Cooldown = 57,
	Animated = true,
	AnimationName = "ShieldHeal",
	Delay = 1.783,
	ExecutionTime = 2.7,
	InstantPlayEffectParentInstanceNames = { "ShieldHeal>SFX" },
	EffectParentInstanceNames = { "ShieldHeal>Heal" },
	HealData = { HealAmount = 240000, ShieldGain = 25000, ShieldCap = 650000 }
}