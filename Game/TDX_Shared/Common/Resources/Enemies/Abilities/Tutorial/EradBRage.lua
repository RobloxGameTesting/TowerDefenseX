local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 1.8,
	ExecutionTime = 6.8,
	AnimationName = "Rage",
	EffectParentInstanceNames = { "RageVFX" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 3,
	PlayEffectsUntilDeath = true,
	TriggeredAtHealthPercentage = 0.5,
	MaximumUses = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.EradBRageStun },
			Range = 1000,
			HitAllTargetsInRange = true
		}
	},
	HealData = { HealAmount = 2000 },
	MovementSpeedIncrease = 0.5,
	ReplaceAnimationMap = { Move = "Move_Rage" }
}