local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local CombatDroneTablet = require(script.Parent:WaitForChild("CombatDroneTablet"))
local animationIds = {
	[EmoteAnimationGroup.Main] = 76565573625337,
	[EmoteAnimationGroup.Start] = 134539604259074
}
local clone = table.clone(CombatDroneTablet)
clone.Name = "CombatDroneTablet R15"
clone.AnimationIds = animationIds
return clone