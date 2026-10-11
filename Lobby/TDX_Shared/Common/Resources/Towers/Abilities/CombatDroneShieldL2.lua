local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "CombatDroneShieldL2",
	DisplayName = "SHIELD LVL 2",
	CustomTriggered = true,
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 30,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	CanRunInParallel = true,
	Icon = "rbxassetid://17684187238",
	Description = "God mode.",
	TargetSelf = true,
	TowerBuffNames = { Enums.TowerBuffs.CombatDroneShieldL2 }
}