local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	AnimationName = "SwordThrow",
	AutoHandleEffects = true,
	Delay = 3,
	ExecutionTime = 3.267,
	TriggeredAtHealthPercentage = 0.4,
	MaximumUses = 1,
	MovementSpeedIncrease = 0,
	HealData = { HealAmount = 10000 },
	GainDamageReductionData = { Amount = 0.9, Time = 3 },
	ParallelAbilityNames = { Enums.EnemyAbilities.ExoVoidSwordThrow_Throw },
	DisableAbilityListIfUsed = {
		Enums.EnemyAbilities.ExoVoidSwordSwing,
		Enums.EnemyAbilities.ExoVoidSwordZap,
		Enums.EnemyAbilities.ExoVoidClawEarthquake,
		Enums.EnemyAbilities.ExoVoidSwordInferno
	},
	ReplaceAnimationMap = { Move = "MoveDamaged" }
}