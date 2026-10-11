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
		EndingBlackDuration = 2,
		EndingBlackFadeInTime = 0.25,
		EndingBlackFadeOutTime = 0.5,
		Duration = 15.91,
		Name = Enums.Cutscenes.Christmas24Part2Victory,
		SpawnArrows = false,
		InsertModelDuringInitialBlack = true,
		InsertModelDelay = 1,
		RemoveModelDuringEndingBlack = true,
		RemoveModelDelay = 1,
		ModelAnimationName = "Animation",
		PlayAnimationOnInitialBlackFadeOut = true,
		SubtitleData = {
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "Fine, I don't need those power crystals anyway,",
				Time = 0.25,
				Duration = 2.5
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "and I certainly don't need to infiltrate some pathetic base to get my hands on them.",
				Time = 3,
				Duration = 4.25
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "Frosty's army was a disappointment,",
				Time = 7.7,
				Duration = 1.7999999999999998
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "just like you.",
				Time = 9.75,
				Duration = 2.25
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "Good luck staying alive, Commander. You're gonna need it.",
				Time = 12.25,
				Duration = 3.75
			}
		}
	}
}