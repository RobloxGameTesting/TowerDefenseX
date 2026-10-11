local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local WarshipThrow = require(script.Parent:WaitForChild("Warship Throw"))
local animationIds = { [EmoteAnimationGroup.Main] = 86811501973771 }
local clone = table.clone(WarshipThrow)
clone.Name = "Warship Throw R15"
clone.AnimationIds = animationIds
return clone