local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "SpawnJeep",
	DisplayName = "Spawn Jeep",
	Passive = false,
	StartingCooldown = 5,
	Cooldown = 25,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://136838642154696",
	Description = "Spawn a jeep.",
	SpawnPathEntityData = {
		{ PathEntityType = Enums.PathEntities.Jeep }
	},
	EffectParentInstanceNames = { "Root>Radio" }
}