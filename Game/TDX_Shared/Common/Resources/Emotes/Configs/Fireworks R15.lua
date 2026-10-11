local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local Fireworks = require(script.Parent:WaitForChild("Fireworks"))
local animationIds = { [EmoteAnimationGroup.Main] = 122442200400081 }
local clone = table.clone(Fireworks)
clone.Name = "Fireworks R15"
clone.AnimationIds = animationIds
return clone