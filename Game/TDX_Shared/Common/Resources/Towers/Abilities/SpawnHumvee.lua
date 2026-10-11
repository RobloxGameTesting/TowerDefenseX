local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "SpawnHumvee",
	DisplayName = "Spawn Humvee",
	Passive = false,
	StartingCooldown = 5,
	Cooldown = 25,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://15022872665",
	Description = "Spawn a humvee.",
	SpawnPathEntityData = {
		{ PathEntityType = Enums.PathEntities.Humvee }
	},
	EffectParentInstanceNames = { "Root>Radio" }
}