local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local PumpkinRide = require(script.Parent:WaitForChild("Pumpkin Ride"))
local animationIds = { [EmoteAnimationGroup.Main] = 104133302646811 }
local clone = table.clone(PumpkinRide)
clone.Name = "Pumpkin Ride R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "Flying Pumpkin Mount R15" }
return clone