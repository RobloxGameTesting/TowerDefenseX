local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 30,
	Animated = true,
	Delay = 1.533,
	ExecutionTime = 2.267,
	AnimationName = "Sword Shock",
	EffectParentInstanceNames = { "ChargingVFX" },
	EffectsStartDelay = 1.033,
	EffectsStopDelay = 1.5,
	EnemyToTowerRangedDataSequence = {
		{
			CanAffectAir = true,
			TowerBuffNames = {
				Enums.TowerBuffs.EradicatorMKICGoldSwordShockStun,
				Enums.TowerBuffs.EradicatorMKICGoldSwordShockDamageDebuff
			},
			Range = 800,
			HitAllTargetsInRange = true,
			EffectParentInstanceName = "SwordShockEffectPart",
			EffectsStartDelay = 1.533,
			EffectsStopDelay = 2.35
		}
	}
}