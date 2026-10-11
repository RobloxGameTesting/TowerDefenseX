local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 4.15,
	ExecutionTime = 5.433,
	AnimationName = "Rage",
	EffectParentInstanceNames = { "InnerFace", "DamagedVFX", "RageModeSmoke" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 3,
	PlayEffectsUntilDeath = true,
	TriggeredAtHealthPercentage = 0.6,
	MaximumUses = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.GingerDreadRageStun },
			Range = 1000,
			HitAllTargetsInRange = true
		}
	},
	HealData = { HealAmount = 25000 },
	MovementSpeedIncrease = 0.5,
	ReplaceAnimationMap = {
		Move = "Damaged_Move",
		Smash = "Damaged_Smash",
		CookieShot = "Damaged_CookieShot",
		CookieBurst = "Damaged_CookieBurst",
		Summon = "Damaged_Summon"
	}
}