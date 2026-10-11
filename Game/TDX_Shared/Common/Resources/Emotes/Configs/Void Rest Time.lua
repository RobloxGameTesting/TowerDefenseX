local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 124138754881861,
	[EmoteAnimationGroup.Start] = 120847459770384,
	[EmoteAnimationGroup.End] = 115869460596800
}
return { Type = Type.Basic, Name = "Void Rest Time", AnimationIds = animationIds }