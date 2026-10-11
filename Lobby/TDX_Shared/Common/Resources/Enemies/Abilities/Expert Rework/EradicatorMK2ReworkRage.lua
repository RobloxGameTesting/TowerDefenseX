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
	ExecutionTime = 17.017,
	AnimationName = "Rage",
	ParallelAbilityNames = {
		Enums.EnemyAbilities.EradicatorMK2ReworkRage_Minigun,
		Enums.EnemyAbilities.EradicatorMK2ReworkRage_Rockets,
		Enums.EnemyAbilities.EradicatorMK2ReworkRage_Scream,
		Enums.EnemyAbilities.EradicatorMK2ReworkRage_ScreamDamage,
		Enums.EnemyAbilities.EradicatorMK2ReworkRage_DroneSupport
	},
	InstantPlayEffectParentInstanceNames = { "Rage>SFX" },
	EffectParentInstanceNames = {
		"Rage>VFX1",
		"Rage>VFX2",
		"Minigun>LeftLowerMachineGun",
		"Minigun>LeftUpperMachineGun",
		"Minigun>RightLowerMachineGun",
		"Minigun>RightUpperMachineGun"
	},
	TriggeredAtHealthPercentage = 0.45,
	MaximumUses = 1,
	MovementSpeedIncrease = 0.9,
	GainDamageReductionData = { Amount = 0.9, Time = 16.95 },
	DisableAbilityListIfUsed = {
		Enums.EnemyAbilities.EradicatorMK2ReworkCruiseMissileGround,
		Enums.EnemyAbilities.EradicatorMK2ReworkCruiseMissileNaval,
		Enums.EnemyAbilities.EradicatorMK2ReworkCruiseMissileAA,
		Enums.EnemyAbilities.EradicatorMK2ReworkRocketRain,
		Enums.EnemyAbilities.EradicatorMK2ReworkRocketRainNaval,
		Enums.EnemyAbilities.EradicatorMK2ReworkDroneSupport
	},
	ReplaceAnimationMap = { Move = "MoveDamaged" }
}