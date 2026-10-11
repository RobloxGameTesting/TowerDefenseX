local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 12,
	Cooldown = 30,
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
	EnemyToTowerRadiusEffectData = {
		DamageData = { Damage = 150 },
		MaximumRange = 8,
		RequeryBeforeExecution = true
	},
	HealData = { ShieldGain = 50000, ShieldCap = 200000 },
	SelfEnemyBuffNames = { Enums.EnemyBuffs.VoidEmpressSpinChargeSpeed },
	GainDamageReductionData = { Amount = 0.85, Time = 7.533333333333334 }
}