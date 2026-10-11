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
		BlackScreenForEntireCutscene = true,
		Duration = 15,
		Name = Enums.Cutscenes.Christmas25Part1Victory,
		SpawnArrows = false,
		InsertModelDuringInitialBlack = true,
		InsertModelDelay = 1,
		RemoveModelDuringEndingBlack = true,
		RemoveModelDelay = 1,
		NoAnimations = true,
		SubtitleData = {
			{
				Name = "???",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "Hey uh, Advisor?",
				Time = 0.25,
				Duration = 2.2
			},
			{
				Name = "???",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "Sorry about the whole robot invasion thing,",
				Time = 2.45,
				Duration = 2.0599999999999996
			},
			{
				Name = "???",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "Eradicator MK 3 went haywire.",
				Time = 4.51,
				Duration = 2.34
			},
			{
				Name = "???",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "By the way uhhh,",
				Time = 6.85,
				Duration = 1.5999999999999996
			},
			{
				Name = "???",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "there's still the robot homeworld 3 clicks north of you.",
				Time = 8.45,
				Duration = 2.75
			},
			{
				Name = "???",
				NameColor = Color3.fromRGB(255, 0, 0),
				Text = "Wanna meet up?",
				Time = 11.2,
				Duration = 3.3000000000000007
			}
		}
	}
}