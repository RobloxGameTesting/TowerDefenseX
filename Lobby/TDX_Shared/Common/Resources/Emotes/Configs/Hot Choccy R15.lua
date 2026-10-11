local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local HotChoccy = require(script.Parent:WaitForChild("Hot Choccy"))
local ServerKeyframeHandler = HotChoccy.ServerKeyframeHandler
local v = { ["Hot Choccy"] = "Hot Choccy R15" }
local animationIds = {
	[EmoteAnimationGroup.Main] = 125746442068259,
	[EmoteAnimationGroup.Interact] = 83092110197053
}
local clone = table.clone(HotChoccy)
clone.Name = "Hot Choccy R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "Hot Choccy R15" }

function clone.ServerKeyframeHandler(p, p2)
	local clone2 = table.clone(p2)

	for k, v2 in v do
		clone2[k] = p2[v2]
	end

	ServerKeyframeHandler(p, clone2)
end

clone.ViewportAnimationId = 83092110197053
return clone