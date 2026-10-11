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
	Delay = 1,
	ExecutionTime = 2.4669999999999996,
	ContinueMovingWhileUsing = true,
	TriggeredAtHealthPercentage = 0.5,
	MaximumUses = 1,
	HealData = { HealAmount = 0 },
	MovementSpeedIncrease = 1.5,
	InstantPlayEffectParentInstanceNames = { "Rage>SFX" },
	ReplaceAnimationMap = { Move = "MoveDamaged" }
}