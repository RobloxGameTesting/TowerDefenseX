local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lang = require(ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Modules"):WaitForChild("Lang"))
require(script.Parent:WaitForChild("DialogueTypes"))
local udim = UDim2.new(1.5, 0, 1.2, 0)
local udim2 = UDim2.new(1.5, 0, 1.2, 0)
return {
	_ExpertDefaults = {
		DefaultName = Lang.Strings.AdvisorNames.AdvisorHalloweenPart4,
		DefaultImage = "rbxassetid://103722341093286",
		DefaultSize = udim,
		DefaultPitch = 1,
		DefaultImageRatio = 75 / 97,
		VolumeOn = true,
		LastInSequenceAfterTextDuration = 5
	},
	ExpertWave41 = {
		Dialogue = {
			{ AfterTextDuration = 0.3 },
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://15897570795",
				ImageSize = udim2,
				ImageRatio = 0.698,
				Pitch = 1.25
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://15897570239",
				ImageSize = udim2,
				ImageRatio = 0.698,
				Pitch = 1.25
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://15897572538",
				ImageSize = udim2,
				ImageRatio = 0.698,
				Pitch = 1.25
			}
		}
	},
	ExpertWave42 = {
		Dialogue = {
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://15897571265",
				ImageSize = udim2,
				ImageRatio = 0.698,
				Pitch = 1.25
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://15897571974",
				ImageSize = udim2,
				ImageRatio = 0.698,
				Pitch = 1.25
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://15897570239",
				ImageSize = udim2,
				ImageRatio = 0.698,
				Pitch = 1.25
			}
		}
	}
}