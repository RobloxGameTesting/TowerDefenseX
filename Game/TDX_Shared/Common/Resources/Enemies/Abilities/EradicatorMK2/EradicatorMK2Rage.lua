local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	CanTargetAir = true,
	TowerBuffNames = { Enums.TowerBuffs.EradicatorMK2RageStun, Enums.TowerBuffs.EradicatorMK2RageDamage },
	Range = 1000,
	HitAllTargetsInRange = true
}
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 1.1,
	ExecutionTime = 3.5,
	AnimationName = "Rage",
	EffectParentInstanceNames = { "RageHeadEffects", "RageModeSmoke" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 3,
	PlayEffectsUntilDeath = true,
	TriggeredAtHealth = 100000,
	MaximumUses = 1,
	NextAbilityName = Enums.EnemyAbilities.EradicatorMK2RocketBarrage,
	EnemyToTowerRangedDataSequence = { v }
}