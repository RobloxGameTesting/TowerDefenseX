local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local EradicatorToy = require(script.Parent:WaitForChild("Eradicator Toy"))
local animationIds = {
	[EmoteAnimationGroup.Main] = 94909142135079,
	[EmoteAnimationGroup.Start] = 71401699749087
}
local clone = table.clone(EradicatorToy)
clone.Name = "Eradicator Toy R15"
clone.AnimationIds = animationIds
return clone