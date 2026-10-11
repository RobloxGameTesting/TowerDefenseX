local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 50,
	Animated = true,
	AnimationName = "SwordShock",
	Delay = 1.5,
	ExecutionTime = 2.8,
	InstantPlayEffectParentInstanceNames = { "SwordShock>SFX" },
	EffectParentInstanceNames = { "SwordShockCharging>Sword" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 1.25,
	EnemyToTowerRangedDataSequence = {
		{
			CanAffectAir = true,
			TowerBuffNames = {
				Enums.TowerBuffs.ZeusSwordShockDisableAbilities,
				Enums.TowerBuffs.ZeusSwordShockFirerateDebuff
			},
			Range = 18,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "SwordShock>SwordShockEffectPart",
			EffectsStartDelay = 1.5,
			EffectsStopDelay = 2.133
		}
	}
}