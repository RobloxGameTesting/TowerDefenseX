local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local Fountain = require(script.Parent:WaitForChild("Fountain"))
local ServerKeyframeHandler = Fountain.ServerKeyframeHandler
local v = { Fountain_Fountain = "Fountain_Fountain R15", Fountain_Lighter = "Fountain_Lighter R15" }
local animationIds = { [EmoteAnimationGroup.Main] = 94708908501817 }
local clone = table.clone(Fountain)
clone.Name = "Fountain R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "Fountain_Fountain R15", "Fountain_Lighter R15" }

function clone.ServerKeyframeHandler(p, p2)
	local clone2 = table.clone(p2)

	for k, v2 in v do
		clone2[k] = p2[v2]
	end

	ServerKeyframeHandler(p, clone2)
end

return clone