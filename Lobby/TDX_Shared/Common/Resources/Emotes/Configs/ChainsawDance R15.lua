local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local ChainsawDance = require(script.Parent:WaitForChild("ChainsawDance"))
local animationIds = { [EmoteAnimationGroup.Main] = 129366628236845 }
local clone = table.clone(ChainsawDance)
clone.Name = "ChainsawDance R15"
clone.AnimationIds = animationIds
return clone