local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local CommanderToy = require(script.Parent:WaitForChild("Commander Toy"))
local ServerKeyframeHandler = CommanderToy.ServerKeyframeHandler
local v = { ["Commander Toy"] = "Commander Toy R15" }
local animationIds = {
	[EmoteAnimationGroup.Main] = 100494092121784,
	[EmoteAnimationGroup.Start] = 109088202107351
}
local clone = table.clone(CommanderToy)
clone.Name = "Commander Toy R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "Commander Toy R15" }

function clone.ServerKeyframeHandler(p, p2)
	local clone2 = table.clone(p2)

	for k, v2 in v do
		clone2[k] = p2[v2]
	end

	ServerKeyframeHandler(p, clone2)
end

clone.ViewportAnimationId = 100494092121784
return clone