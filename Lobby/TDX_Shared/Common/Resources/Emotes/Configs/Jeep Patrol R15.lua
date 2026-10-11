local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local JeepPatrol = require(script.Parent:WaitForChild("Jeep Patrol"))
local ServerKeyframeHandler = JeepPatrol.ServerKeyframeHandler
local v = { ["Jeep Patrol"] = "Jeep Patrol R15" }
local animationIds = {
	[EmoteAnimationGroup.Main] = 96334321854847,
	[EmoteAnimationGroup.Start] = 97025435942552,
	[EmoteAnimationGroup.End] = 109144292436675,
	[EmoteAnimationGroup.Moving] = 95591152857050
}
local clone = table.clone(JeepPatrol)
clone.Name = "Jeep Patrol R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "Jeep Patrol R15" }

function clone.ServerKeyframeHandler(p, p2)
	local clone2 = table.clone(p2)

	for k, v2 in v do
		clone2[k] = p2[v2]
	end

	ServerKeyframeHandler(p, clone2)
end

return clone