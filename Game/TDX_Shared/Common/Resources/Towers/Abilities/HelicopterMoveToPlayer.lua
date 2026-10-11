local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "HelicopterMoveToPlayer",
	DisplayName = "Follow player",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 5,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://77783871774019",
	FullSizeIcon = true,
	Description = "Follow player",
	ChangeHelicopterMovementTo = Enums.HelicopterModes.MoveToPlayer,
	DisplayStatAdditions = {
		{ Text = "FOLLOW PLAYER", ImageId = "rbxassetid://83017077237761", ImageScale = 1 }
	},
	EffectParentInstanceNames = { "Ability_FollowPlayer" },
	EffectsForOwnerOnly = true
}