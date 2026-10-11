local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WaveTypes"))
return {
	{
		InitialBlackDuration = 2,
		InitialBlackFadeInTime = 0.5,
		InitialBlackFadeOutTime = 0.5,
		Duration = 5,
		Name = Enums.Cutscenes.Test,
		SpawnArrows = true,
		InsertModelDuringInitialBlack = true,
		InsertModelDelay = 1,
		ModelAnimationName = "Animation",
		PlayAnimationOnInitialBlackFadeOut = true,
		SubtitleData = {
			{
				Name = "Medic #1",
				NameColor = Color3.fromRGB(250, 116, 255),
				Text = "Welcome!",
				Time = 3.25,
				Duration = 2.25
			},
			{
				Name = "Medic #2",
				NameColor = Color3.fromRGB(59, 177, 255),
				Text = "Test test test test. Test test test test.",
				Time = 6,
				Duration = 5
			}
		}
	},
	{
		InitialBlackDuration = 1,
		InitialBlackFadeInTime = 0.5,
		InitialBlackFadeOutTime = 0.5,
		Duration = 1,
		Name = Enums.Cutscenes.Test,
		SpawnArrows = true,
		ModelAnimationName = "Animation2",
		PlayAnimationOnInitialBlackFadeOut = true
	},
	{
		EndingBlackDuration = 2,
		EndingBlackFadeInTime = 0.5,
		EndingBlackFadeOutTime = 0.5,
		Duration = 1.5,
		Name = Enums.Cutscenes.Test,
		SpawnArrows = true,
		RemoveModelDuringEndingBlack = true,
		RemoveModelDelay = 1,
		ModelAnimationName = "Animation3"
	}
}