local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local BenchRest = require(script.Parent:WaitForChild("Bench Rest"))
local animationIds = {
	[EmoteAnimationGroup.Main] = 127697406452830,
	[EmoteAnimationGroup.Start] = 111291110197941
}
local clone = table.clone(BenchRest)
clone.Name = "Bench Rest R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "Bench R15" }
return clone