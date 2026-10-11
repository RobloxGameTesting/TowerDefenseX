local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 75703593691862,
	[EmoteAnimationGroup.Start] = 134116462069334
}
return {
	Type = Type.Basic,
	Name = "BBQ",
	AnimationIds = animationIds,
	ModelNames = { "BBQBase", "BBQSpatula" }
}