local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 0.883,
	ExecutionTime = 6.933,
	AnimationName = "Rage",
	EffectParentInstanceNames = {
		"1UpperJaw",
		"DamagedVFX",
		"RageModeSmoke",
		"ForceFieldActivate_Rage"
	},
	EffectsStartDelay = 0,
	EffectsStopDelay = 3,
	PlayEffectsUntilDeath = true,
	TriggeredAtHealth = 300000,
	MaximumUses = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.EradicatorMKICRageStun },
			Range = 1000,
			HitAllTargetsInRange = true
		}
	},
	HealData = { HealAmount = 100000000, ShieldGain = 250000, ShieldCap = 250000, Delay = 5.4 },
	MovementSpeedIncrease = 0.4
}