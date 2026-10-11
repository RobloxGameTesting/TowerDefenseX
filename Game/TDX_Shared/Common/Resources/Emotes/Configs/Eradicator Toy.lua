local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 84025803044269,
	[EmoteAnimationGroup.Start] = 123769891492746
}
return {
	Type = Type.Basic,
	Name = "Eradicator Toy",
	AnimationIds = animationIds,
	ModelNames = { "EradicatorToy" },
	MainAnimationDelay = 6
}