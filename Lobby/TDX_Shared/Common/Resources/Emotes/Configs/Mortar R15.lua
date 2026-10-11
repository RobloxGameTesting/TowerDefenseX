local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local Mortar = require(script.Parent:WaitForChild("Mortar"))
local animationIds = { [EmoteAnimationGroup.Main] = 86250753771327 }
local clone = table.clone(Mortar)
clone.Name = "Mortar R15"
clone.AnimationIds = animationIds
return clone