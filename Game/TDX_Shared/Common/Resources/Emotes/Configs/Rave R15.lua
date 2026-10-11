local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local Rave = require(script.Parent:WaitForChild("Rave"))
local animationIds = { [EmoteAnimationGroup.Main] = 90894004767449 }
local clone = table.clone(Rave)
clone.Name = "Rave R15"
clone.AnimationIds = animationIds
return clone