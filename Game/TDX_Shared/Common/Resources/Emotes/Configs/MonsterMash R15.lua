local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local MonsterMash = require(script.Parent:WaitForChild("MonsterMash"))
local animationIds = { [EmoteAnimationGroup.Main] = 80399372654355 }
local clone = table.clone(MonsterMash)
clone.Name = "MonsterMash R15"
clone.AnimationIds = animationIds
return clone