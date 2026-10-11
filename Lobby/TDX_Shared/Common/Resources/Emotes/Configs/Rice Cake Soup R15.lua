local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local RiceCakeSoup = require(script.Parent:WaitForChild("Rice Cake Soup"))
local ServerKeyframeHandler = RiceCakeSoup.ServerKeyframeHandler
local v = {
	["Rice Cake Soup_Soup"] = "Rice Cake Soup_Soup R15",
	["Rice Cake Soup_Sticks"] = "Rice Cake Soup_Sticks R15"
}
local animationIds = {
	[EmoteAnimationGroup.Main] = 70726415528731,
	[EmoteAnimationGroup.Start] = 122267812700690,
	[EmoteAnimationGroup.End] = 95250969669800
}
local clone = table.clone(RiceCakeSoup)
clone.Name = "Rice Cake Soup R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "Rice Cake Soup_Soup R15", "Rice Cake Soup_Sticks R15" }

function clone.ServerKeyframeHandler(p, p2)
	local clone2 = table.clone(p2)

	for k, v2 in v do
		clone2[k] = p2[v2]
	end

	ServerKeyframeHandler(p, clone2)
end

return clone