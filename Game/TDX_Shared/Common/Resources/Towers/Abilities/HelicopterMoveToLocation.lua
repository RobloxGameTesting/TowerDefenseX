local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "HelicopterMoveToLocation",
	DisplayName = "Move to location",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 3,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://131925482088185",
	Description = "Move to location",
	ChangeHelicopterMovementTo = Enums.HelicopterModes.MoveToLocation,
	IsManualAimAtGround = true,
	ManualAimInfiniteRange = true,
	DisplayStatAdditions = {
		{ Text = "MOVE TO LOCATION", ImageId = "rbxassetid://83017077237761", ImageScale = 1 }
	},
	EffectParentInstanceNames = { "Ability_MoveToLocation" },
	EffectsForOwnerOnly = true
}