local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 50,
	Cooldown = 50,
	Animated = true,
	Delay = 1.2,
	ExecutionTime = 2.217,
	AnimationName = "Shield Gain",
	EffectParentInstanceNames = { "Torso>ShieldGain" },
	HealData = { ShieldGain = 1000000, ShieldCap = 2000000 }
}