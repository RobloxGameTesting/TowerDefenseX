local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lang = require(ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Modules"):WaitForChild("Lang"))
require(script.Parent:WaitForChild("DialogueTypes"))
local udim = UDim2.new(1.5, 0, 1.2, 0)
return {
	_Christmas25Part1EasyDefaults = {
		DefaultName = Lang.Strings.AdvisorNames.AdvisorHalloweenPart4,
		DefaultImage = "rbxassetid://103722341093286",
		DefaultSize = udim,
		DefaultPitch = 1,
		DefaultImageRatio = 75 / 97,
		VolumeOn = true,
		LastInSequenceAfterTextDuration = 5
	}
}