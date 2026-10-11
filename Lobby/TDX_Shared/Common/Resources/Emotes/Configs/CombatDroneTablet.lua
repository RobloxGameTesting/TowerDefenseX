local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 80139603316178,
	[EmoteAnimationGroup.Start] = 101534424328135
}
return {
	Type = Type.Basic,
	Name = "CombatDroneTablet",
	AnimationIds = animationIds,
	ModelNames = { "CombatDroneTablet" },
	MainAnimationDelay = 1.1,
	CanAlwaysPlay = true
}