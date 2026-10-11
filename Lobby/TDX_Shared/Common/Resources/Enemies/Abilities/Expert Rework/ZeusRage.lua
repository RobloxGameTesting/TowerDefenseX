local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	AnimationName = "Rage",
	Delay = 0,
	ExecutionTime = 3.9669999999999996,
	InstantPlayEffectParentInstanceNames = { "Rage>SFX" },
	EffectParentInstanceNames = { "Rage>VFX" },
	EffectsStartDelay = 1.75,
	PlayEffectsUntilDeath = true,
	TriggeredAtHealthPercentage = 0.6,
	MaximumUses = 1,
	HealData = { HealAmount = 10000 },
	MovementSpeedIncrease = 0.7,
	ReplaceAnimationMap = { Move = "MoveDamaged" }
}