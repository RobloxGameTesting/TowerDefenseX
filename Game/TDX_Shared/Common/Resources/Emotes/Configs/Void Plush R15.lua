local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local VoidPlush = require(script.Parent:WaitForChild("Void Plush"))
local ServerKeyframeHandler = VoidPlush.ServerKeyframeHandler
local animationIds = {
	[EmoteAnimationGroup.Main] = 88162255659260,
	[EmoteAnimationGroup.Start] = 88411061245825,
	[EmoteAnimationGroup.Interact] = 97135298140654,
	[EmoteAnimationGroup.End] = 105424361972396
}
local clone = table.clone(VoidPlush)
clone.Name = "Void Plush R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "Void Plush R15" }

function clone.ServerKeyframeHandler(p, p2)
	ServerKeyframeHandler(p, { ["Void Plush"] = p2["Void Plush R15"] })
end

clone.ViewportAnimationId = 97135298140654
return clone