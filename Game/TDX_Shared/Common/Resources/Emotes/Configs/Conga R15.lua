local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local Conga = require(script.Parent:WaitForChild("Conga"))
local animationIds = {
	[EmoteAnimationGroup.Main] = {
		76318089962909,
		139326190583074,
		78688451651676,
		123616504674097,
		104638692681191
	}
}
local clone = table.clone(Conga)
clone.Name = "Conga R15"
clone.AnimationIds = animationIds
return clone