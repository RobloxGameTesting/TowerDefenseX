local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 1.5,
	ExecutionTime = 7.2,
	AnimationName = "Rage",
	EffectParentInstanceNames = { "InnerFace", "DamagedVFX", "RageModeSmoke" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 3,
	PlayEffectsUntilDeath = true,
	TriggeredAtHealth = 85000,
	MaximumUses = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.EradicatorRageStun },
			Range = 1000,
			HitAllTargetsInRange = true
		}
	},
	HealData = { HealAmount = 10000, Delay = 3.5 },
	MovementSpeedIncrease = 0.3
}