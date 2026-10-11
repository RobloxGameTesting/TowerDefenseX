local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 70,
	Cooldown = 100,
	Animated = true,
	AnimationName = "Heal",
	Delay = 1.8,
	ExecutionTime = 4.133,
	EffectParentInstanceNames = { "LowerLeftArm>HealVFX" },
	EffectsStartDelay = 1.2,
	EffectsStopDelay = 2.5,
	HealData = { HealAmount = 250000 }
}