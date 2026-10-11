local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local VoidRestTime = require(script.Parent:WaitForChild("Void Rest Time"))
local animationIds = {
	[EmoteAnimationGroup.Main] = 95054878428469,
	[EmoteAnimationGroup.Start] = 105321658668523,
	[EmoteAnimationGroup.End] = 77161805557104
}
local clone = table.clone(VoidRestTime)
clone.Name = "Void Rest Time R15"
clone.AnimationIds = animationIds
return clone