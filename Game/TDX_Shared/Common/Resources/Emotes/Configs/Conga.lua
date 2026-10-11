local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Type = Enums.Emotes.Type
local animationIds = {
	[Enums.Emotes.EmoteAnimationGroup.Main] = {
		18961347158,
		18961349397,
		18961351980,
		18961353589,
		18961355709
	}
}
return {
	Type = Type.Basic,
	Name = "Conga",
	AnimationIds = animationIds,
	EmoteSoundData = { SoundId = 18961572950 },
	IsPartner = true
}