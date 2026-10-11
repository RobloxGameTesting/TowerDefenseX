local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 1.1,
	ExecutionTime = 3.35,
	AnimationName = "Rage",
	EffectParentInstanceNames = { "InnerFace", "RageModeSmoke" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 2.35,
	TriggeredAtHealthPercentage = 0.6,
	MaximumUses = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.GeneralCelgarRageStun },
			Range = 1000,
			HitAllTargetsInRange = true
		}
	},
	HealData = { HealAmount = 25000 }
}