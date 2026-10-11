local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "ShieldTowerUnstunField",
	DisplayName = "Unstun Field LVL 2",
	Passive = false,
	CanUseWhileStunned = true,
	StartingCooldown = 0,
	Cooldown = 25,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://17307873959",
	Description = "Instantly unstun nearby towers.",
	HasRadiusEffect = true,
	UseTowerRangeForRadius = true,
	Unstun = true,
	EffectParentInstanceNames = { "Root" }
}