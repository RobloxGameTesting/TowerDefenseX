local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Type = Enums.Emotes.Type
local animationIds = { [Enums.Emotes.EmoteAnimationGroup.Main] = 16298442521 }
return { Type = Type.Basic, Name = "StockShuffle", AnimationIds = animationIds }