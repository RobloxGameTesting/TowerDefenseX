local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 0,
	ExecutionTime = 0.5,
	AnimationName = "Rage",
	EffectParentInstanceNames = {},
	TriggeredAtHealth = 850000,
	MaximumUses = 1,
	DisableAbilityListIfUsed = {
		Enums.EnemyAbilities.EradicatorMK4GoldArtilleryShot,
		Enums.EnemyAbilities.EradicatorMK4GoldArtillerySmokeShot,
		Enums.EnemyAbilities.EradicatorMK4GoldRocketBarrage,
		Enums.EnemyAbilities.EradicatorMK4GoldToxicGasGrenade,
		Enums.EnemyAbilities.EradicatorMK4GoldExplosiveGrenade,
		Enums.EnemyAbilities.EradicatorMK4GoldStunGrenade,
		Enums.EnemyAbilities.EradicatorMK4GoldFireGrenade
	},
	MovementSpeedIncrease = 7
}