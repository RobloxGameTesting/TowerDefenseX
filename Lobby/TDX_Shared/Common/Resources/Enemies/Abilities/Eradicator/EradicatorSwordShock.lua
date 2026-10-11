local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 6,
	Cooldown = 50,
	Animated = true,
	Delay = 1,
	ExecutionTime = 2.55,
	AnimationName = "Sword Shock",
	EffectParentInstanceNames = { "ChargingVFX" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 0.8,
	EnemyToTowerRangedDataSequence = {
		{
			CanAffectAir = true,
			TowerBuffNames = {
				Enums.TowerBuffs.EradicatorSwordShockDisableAbilities,
				Enums.TowerBuffs.EradicatorSwordShockFirerateDebuff
			},
			Range = 18,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "SwordShockEffectPart",
			EffectsStartDelay = 1,
			EffectsStopDelay = 2.35
		}
	}
}