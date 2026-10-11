local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 18459610835,
	[EmoteAnimationGroup.Start] = 18459606249
}
return {
	Type = Type.Basic,
	Name = "Bench Rest",
	AnimationIds = animationIds,
	ModelNames = { "Bench" }
}