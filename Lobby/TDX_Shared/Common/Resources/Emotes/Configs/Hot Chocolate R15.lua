local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local HotChocolate = require(script.Parent:WaitForChild("Hot Chocolate"))
local animationIds = {
	[EmoteAnimationGroup.Main] = 106467247180523,
	[EmoteAnimationGroup.Interact] = 105147243948012
}
local clone = table.clone(HotChocolate)
clone.Name = "Hot Chocolate R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "Hot Chocolate R15" }
return clone