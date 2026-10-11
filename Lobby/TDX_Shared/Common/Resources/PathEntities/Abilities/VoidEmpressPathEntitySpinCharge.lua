local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Spin Charge",
	StartingCooldown = 5,
	Cooldown = 10,
	Animated = true,
	AnimationName = "SpinCharge",
	AutoHandleEffects = true,
	Delay = 11 / 15,
	ExecutionTime = 8.066666666666668,
	EffectsStartDelay = 11 / 15,
	EffectsStopDelay = 427 / 60,
	ToggleShieldModelForTime = 8.066666666666668,
	BurstSize = 14,
	BurstInterval = 0.5,
	ContinueMovingWhileUsing = true,
	PathEntityToEnemyRadiusEffectData = {
		Damage = 250,
		DamageType = Enums.DamageTypes.Melee,
		MaximumRange = 12,
		RequeryBeforeExecution = true
	},
	GainDamageReductionData = { Amount = 0.8, Time = 7.533333333333334 }
}