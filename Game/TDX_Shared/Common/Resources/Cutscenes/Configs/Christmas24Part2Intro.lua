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
		Duration = 30.35,
		Name = Enums.Cutscenes.Christmas24Part2Intro,
		SpawnArrows = true,
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
				Text = "Long thought to be extinct, I... revived General Celgar.",
				Time = 0.5,
				Duration = 4.5
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "Something the Advisor didn't want me to do.",
				Time = 5.5,
				Duration = 2.75
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "I was naive.",
				Time = 8.5,
				Duration = 1.75
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "I could have saved him, you know.",
				Time = 10.5,
				Duration = 3
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "But it doesn't matter anymore.",
				Time = 15.75,
				Duration = 1.75
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "But it doesn't matter anymore.",
				Time = 15.75,
				Duration = 1.75
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "The GDA is weak.",
				Time = 17.5,
				Duration = 2
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "I was weak.",
				Time = 19.75,
				Duration = 2.5
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "But I am not weak.",
				Time = 22.5,
				Duration = 3
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "I WILL have my vengeance.",
				Time = 25.75,
				Duration = 2.75
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "STARTING WITH YOU!",
				Time = 28.5,
				Duration = 3.5
			}
		}
	}
}