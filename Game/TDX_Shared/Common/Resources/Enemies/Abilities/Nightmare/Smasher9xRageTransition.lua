local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 0,
	Cooldown = 1e999,
	Animated = true,
	Delay = 1.1,
	ExecutionTime = 10 / 3,
	AnimationName = "RageStart",
	EffectParentInstanceNames = { "HumanoidRootPart>ScreamSFX" },
	EffectsStartDelay = 0,
	MaximumUses = 1,
	DisableAbilityListIfUsed = { "Smasher9xTremor" },
	MovementSpeedIncrease = 3.6,
	ReplaceAnimationMap = { Move = "Run" },
	HealData = { ShieldGain = 100, ShieldCap = 100 },
	TriggeredAtHealthPercentage = 0.6,
	GainDamageReductionData = { Amount = 0.9, Time = 3 },
	ToggleShieldModelForTime = 3
}