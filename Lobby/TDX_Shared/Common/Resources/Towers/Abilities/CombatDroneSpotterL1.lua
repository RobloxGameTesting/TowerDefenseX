local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "CombatDroneSpotter1",
	DisplayName = "SPOTTER LVL 1",
	CustomTriggered = true,
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 30,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	CanRunInParallel = true,
	Icon = "rbxassetid://17684187238",
	Description = "Make target enemy take extra damage and move slower.",
	EnemyBuffNames = { Enums.EnemyBuffs.CombatDroneSpotterSpeedDebuffL1 },
	EnemyDamageData = {
		IgnoreResistance = false,
		ExtraDamageData = {
			ExtraDamageHash = "CombatDroneSpotter",
			Duration = 10,
			DamageMultiplier = 0.1,
			BossDamageMultiplier = 0.05
		}
	},
	IsManualAimAtEnemy = true
}