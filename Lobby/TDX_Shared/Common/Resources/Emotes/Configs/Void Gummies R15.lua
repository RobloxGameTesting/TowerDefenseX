local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local VoidGummies = require(script.Parent:WaitForChild("Void Gummies"))
local ServerKeyframeHandler = VoidGummies.ServerKeyframeHandler
local animationIds = {
	[EmoteAnimationGroup.Main] = 93964491586230,
	[EmoteAnimationGroup.Start] = 70605675237563,
	[EmoteAnimationGroup.Interact] = 79549383672129,
	[EmoteAnimationGroup.End] = 74847561084003
}
local clone = table.clone(VoidGummies)
clone.Name = "Void Gummies R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "Void Gummies R15" }

function clone.ServerKeyframeHandler(p, p2)
	ServerKeyframeHandler(p, { ["Void Gummies"] = p2["Void Gummies R15"] })
end

clone.ViewportAnimationId = 79549383672129
return clone