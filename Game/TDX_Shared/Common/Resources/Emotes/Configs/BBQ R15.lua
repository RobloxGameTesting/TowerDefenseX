local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local BBQ = require(script.Parent:WaitForChild("BBQ"))
local animationIds = {
	[EmoteAnimationGroup.Main] = 111187946925592,
	[EmoteAnimationGroup.Start] = 123770435121345
}
local clone = table.clone(BBQ)
clone.Name = "BBQ R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "BBQBase", "BBQSpatula R15" }
return clone