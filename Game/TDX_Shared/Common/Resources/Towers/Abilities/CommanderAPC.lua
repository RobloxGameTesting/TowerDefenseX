local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "CommanderAPC",
	DisplayName = "Spawn APC",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 30,
	Animated = true,
	Delay = 0,
	ExecutionTime = 5,
	Icon = "rbxassetid://18462088338",
	FullSizeIcon = true,
	Description = "Spawn an APC.",
	AnimationName = "Stryker Call",
	SpawnPathEntityData = {
		{ PathEntityType = Enums.PathEntities.APC }
	},
	EffectParentInstanceNames = { "StrykerRush" }
}