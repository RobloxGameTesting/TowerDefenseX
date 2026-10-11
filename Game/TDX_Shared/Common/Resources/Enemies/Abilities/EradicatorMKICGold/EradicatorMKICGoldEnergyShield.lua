local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 25,
	Cooldown = 80,
	Animated = true,
	Delay = 1.783,
	ExecutionTime = 2.7,
	AnimationName = "Energy Shield",
	EffectParentInstanceNames = { "ForceFieldActivate_EnergyShield" },
	HealData = { ShieldGain = 450000, ShieldCap = 750000 }
}