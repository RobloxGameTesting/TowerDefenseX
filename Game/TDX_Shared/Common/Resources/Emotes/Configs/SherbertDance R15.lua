local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local SherbertDance = require(script.Parent:WaitForChild("SherbertDance"))
local animationIds = { [EmoteAnimationGroup.Main] = 96963966666162 }
local clone = table.clone(SherbertDance)
clone.Name = "SherbertDance R15"
clone.AnimationIds = animationIds
return clone