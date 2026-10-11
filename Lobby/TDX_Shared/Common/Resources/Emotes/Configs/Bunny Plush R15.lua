local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local BunnyPlush = require(script.Parent:WaitForChild("Bunny Plush"))
local ServerKeyframeHandler = BunnyPlush.ServerKeyframeHandler
local v = { ["Bunny Plush"] = "Bunny Plush R15" }
local animationIds = {
	[EmoteAnimationGroup.Main] = 130488767538058,
	[EmoteAnimationGroup.Interact] = 108391641392717
}
local clone = table.clone(BunnyPlush)
clone.Name = "Bunny Plush R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "Bunny Plush R15" }

function clone.ServerKeyframeHandler(p, p2)
	local clone2 = table.clone(p2)

	for k, v2 in v do
		clone2[k] = p2[v2]
	end

	ServerKeyframeHandler(p, clone2)
end

clone.ViewportAnimationId = 108391641392717
return clone