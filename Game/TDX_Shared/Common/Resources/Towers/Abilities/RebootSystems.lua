local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "RebootSystems",
	DisplayName = "Reboot Systems",
	Passive = false,
	CanUseWhileStunned = true,
	StartingCooldown = 0,
	Cooldown = 10,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://17154697248",
	Description = "Instantly unstun.",
	TargetSelf = true,
	Unstun = true,
	HealAmount = 2000,
	TowerBuffNames = { Enums.TowerBuffs.RebootSystemsDamageBuff },
	EffectParentInstanceNames = {}
}