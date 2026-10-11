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
	TriggeredAtHealth = 190000,
	MaximumUses = 1,
	DisableAbilityListIfUsed = {
		Enums.EnemyAbilities.EradicatorMK4ArtilleryShot,
		Enums.EnemyAbilities.EradicatorMK4ArtillerySmokeShot,
		Enums.EnemyAbilities.EradicatorMK4RocketBarrage,
		Enums.EnemyAbilities.EradicatorMK4NightmareToxicGasGrenade,
		Enums.EnemyAbilities.EradicatorMK4ExplosiveGrenade,
		Enums.EnemyAbilities.EradicatorMK4StunGrenade,
		Enums.EnemyAbilities.EradicatorMK4FireGrenade
	},
	MovementSpeedIncrease = 7
}