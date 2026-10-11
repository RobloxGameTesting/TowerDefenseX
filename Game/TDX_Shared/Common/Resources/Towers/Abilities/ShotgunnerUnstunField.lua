local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "ShotgunnerUnstunField",
	DisplayName = "Unstun Power",
	Passive = false,
	CanUseWhileStunned = true,
	StartingCooldown = 0,
	Cooldown = 35,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://17307873959",
	Description = "Instantly unstun nearby towers.",
	HasRadiusEffect = true,
	EffectRadius = 7,
	Unstun = true,
	EffectParentInstanceNames = { "Root" }
}