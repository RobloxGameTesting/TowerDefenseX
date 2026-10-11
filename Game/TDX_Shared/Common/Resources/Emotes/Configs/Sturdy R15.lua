local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local Sturdy = require(script.Parent:WaitForChild("Sturdy"))
local animationIds = { [EmoteAnimationGroup.Main] = 96224096665666 }
local clone = table.clone(Sturdy)
clone.Name = "Sturdy R15"
clone.AnimationIds = animationIds
return clone