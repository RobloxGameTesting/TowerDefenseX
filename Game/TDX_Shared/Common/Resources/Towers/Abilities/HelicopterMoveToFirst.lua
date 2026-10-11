local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "HelicopterMoveToFirst",
	DisplayName = "Move to first enemy",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 5,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://80020795434617",
	FullSizeIcon = true,
	Description = "Move to first enemy",
	ChangeHelicopterMovementTo = Enums.HelicopterModes.MoveToFirst,
	DisplayStatAdditions = {
		{ Text = "FOLLOW FIRST ENEMY", ImageId = "rbxassetid://83017077237761", ImageScale = 1 }
	},
	EffectParentInstanceNames = { "Ability_Pursuit" },
	EffectsForOwnerOnly = true
}