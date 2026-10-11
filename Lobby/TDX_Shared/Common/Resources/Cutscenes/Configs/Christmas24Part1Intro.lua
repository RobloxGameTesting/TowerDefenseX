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
		Duration = 28.58,
		Name = Enums.Cutscenes.Christmas24Part1Intro,
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
				Text = "Hello, Commander.",
				Time = 1.3,
				Duration = 1.7
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "Don't mind if I tap into your communications systems for a bit.",
				Time = 3.783,
				Duration = 6.5
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "I'll have to admit, you and your forces fighting the Awakened was a surprise to see.",
				Time = 8.383,
				Duration = 5.1
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "A costly victory.",
				Time = 13.383,
				Duration = 2.2
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "However, with your army drained, I think it's my time to intervene again, don't you think?",
				Time = 15.582999999999998,
				Duration = 6.1
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "I am sending out a scout force, some of them you might remember.",
				Time = 22.483,
				Duration = 4.1
			},
			{
				Name = "Dr. Xenon",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "Try not to lose to them, mkay?",
				Time = 26.483,
				Duration = 4
			}
		}
	}
}