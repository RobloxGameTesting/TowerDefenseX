local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 35,
	Animated = true,
	AnimationName = "Shock",
	Delay = 2,
	ExecutionTime = 2.9669999999999996,
	InstantPlayEffectParentInstanceNames = { "Shock>SFX" },
	EffectParentInstanceNames = { "ShockCharging" },
	EffectsStartDelay = 1.5,
	EffectsStopDelay = 1.95,
	EnemyToTowerRangedDataSequence = {
		{
			CanAffectAir = true,
			TowerBuffNames = {
				Enums.TowerBuffs.ArtemisShockDisableAbilities,
				Enums.TowerBuffs.ArtemisShockFirerateDebuff
			},
			Range = 18,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "Shock>Root",
			EffectsStartDelay = 2,
			EffectsStopDelay = 3
		}
	}
}