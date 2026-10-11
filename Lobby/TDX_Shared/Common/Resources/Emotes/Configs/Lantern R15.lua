local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local Lantern = require(script.Parent:WaitForChild("Lantern"))
local ServerKeyframeHandler = Lantern.ServerKeyframeHandler
local v = { Lantern_Lighter = "Lantern_Lighter R15", Lantern_Lantern = "Lantern_Lantern R15" }
local animationIds = { [EmoteAnimationGroup.Main] = 121861547611401 }
local clone = table.clone(Lantern)
clone.Name = "Lantern R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "Lantern_Lighter R15", "Lantern_Lantern R15" }

function clone.ServerKeyframeHandler(p, p2)
	local clone2 = table.clone(p2)

	for k, v2 in v do
		clone2[k] = p2[v2]
	end

	ServerKeyframeHandler(p, clone2)
end

return clone