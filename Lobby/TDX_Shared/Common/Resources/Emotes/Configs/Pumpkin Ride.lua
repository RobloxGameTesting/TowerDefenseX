local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Type = Enums.Emotes.Type
local animationIds = { [Enums.Emotes.EmoteAnimationGroup.Main] = 133644773106015 }
return {
	Type = Type.Basic,
	Name = "Pumpkin Ride",
	AnimationIds = animationIds,
	ModelNames = { "Flying Pumpkin Mount" },
	ViewportOffset = vector.create(0, -1, -250)
}