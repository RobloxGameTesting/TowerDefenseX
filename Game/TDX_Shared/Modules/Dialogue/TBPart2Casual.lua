local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lang = require(ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Modules"):WaitForChild("Lang"))
require(script.Parent:WaitForChild("DialogueTypes"))
local udim = UDim2.new(1.5, 0, 1.2, 0)
return {
	_TBPart2CasualDefaults = {
		DefaultName = Lang.Strings.AdvisorNames.Default,
		DefaultImage = "rbxassetid://14063853703",
		DefaultSize = udim,
		DefaultPitch = 1,
		DefaultImageRatio = 0.776,
		VolumeOn = true,
		LastInSequenceAfterTextDuration = 5
	}
}