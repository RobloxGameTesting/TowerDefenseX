local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "SpawnLAV25",
	DisplayName = "Spawn LAV-25",
	Passive = false,
	StartingCooldown = 5,
	Cooldown = 60,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://92082666530640",
	Description = "Spawn a JAV-25.",
	SpawnPathEntityData = {
		{ PathEntityType = Enums.PathEntities.LAV25 }
	},
	EffectParentInstanceNames = { "Root>Radio" }
}