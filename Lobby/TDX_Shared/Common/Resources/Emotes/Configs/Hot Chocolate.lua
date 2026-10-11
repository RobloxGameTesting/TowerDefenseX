local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 115369709480110,
	[EmoteAnimationGroup.Interact] = 83589685437249
}
return {
	Type = Type.Basic,
	Name = "Hot Chocolate",
	AnimationIds = animationIds,
	ModelNames = { "Hot Chocolate" }
}