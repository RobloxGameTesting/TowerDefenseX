local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 50,
	Animated = true,
	AnimationName = "SwordStun",
	Delay = 1.117,
	ExecutionTime = 2.4669999999999996,
	InstantPlayEffectParentInstanceNames = { "SwordShock>SFX" },
	EffectParentInstanceNames = { "SwordShockCharging>Sword" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanAffectAir = true,
			TowerBuffNames = { Enums.TowerBuffs.KingSwordStun },
			DamageData = { Damage = 50 },
			Range = 10,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "SwordShock>SwordShockEffectPart",
			EffectsStartDelay = 1.117,
			EffectsStopDelay = 2.133
		}
	},
	EnemyToTowerRadiusEffectData = {
		DoNotUseForTriggering = true,
		RequeryBeforeExecution = true,
		MaximumRange = 40,
		TowerBuffNames = { Enums.TowerBuffs.KingSwordStunFirerateDebuff }
	}
}