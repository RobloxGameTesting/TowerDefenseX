local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 0.65,
	ExecutionTime = 3.4000000000000004,
	AnimationName = "Rage",
	EffectParentInstanceNames = { "RageModeSmoke" },
	TriggeredAtHealth = 1000000,
	MaximumUses = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.CalamityRageStun },
			Range = 1000,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		DoNotUseForTriggering = true,
		DamageData = { DamagePercentage = 0.5 },
		HitPercentage = 1,
		AffectTargetsWithNoAttack = true
	},
	DisableAbilityListIfUsed = { Enums.EnemyAbilities.NightmareCalamity1StompPreRage },
	HealData = { HealAmount = 1000000, Delay = 0 },
	MovementSpeedIncrease = 6.3
}