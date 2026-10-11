local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 30,
	Cooldown = 69,
	Animated = true,
	Delay = 1.2,
	ExecutionTime = 2.217,
	AnimationName = "Shield Gain",
	EffectParentInstanceNames = { "Torso>ShieldGain" },
	HealData = { ShieldGain = 850000, ShieldCap = 1500000 }
}