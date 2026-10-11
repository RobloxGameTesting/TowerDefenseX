local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local StockShuffle = require(script.Parent:WaitForChild("StockShuffle"))
local animationIds = { [EmoteAnimationGroup.Main] = 87883871336025 }
local clone = table.clone(StockShuffle)
clone.Name = "StockShuffle R15"
clone.AnimationIds = animationIds
return clone