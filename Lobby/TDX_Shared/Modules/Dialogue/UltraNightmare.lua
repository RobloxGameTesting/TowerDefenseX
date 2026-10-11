local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lang = require(ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Modules"):WaitForChild("Lang"))
require(script.Parent:WaitForChild("DialogueTypes"))
local udim = UDim2.new(1.7, 0, 1.5, 0)
return {
	_UltraNightmareDefaults = {
		DefaultName = Lang.Strings.AdvisorNames.GeneralLeah,
		DefaultImage = "rbxassetid://134532644056587",
		DefaultSize = udim,
		DefaultPitch = 1.08,
		DefaultImageRatio = 0.775,
		VolumeOn = true,
		LastInSequenceAfterTextDuration = 5
	},
	UltraNightmareWave2 = {
		Dialogue = {
			{ Image = "rbxassetid://135780743681076" },
			{ Image = "rbxassetid://134532644056587" }
		}
	},
	UltraNightmareWave3 = {
		Dialogue = {
			{ Image = "rbxassetid://119803823442390" }
		}
	},
	UltraNightmareWave4 = {
		Dialogue = {
			{ Image = "rbxassetid://136599034577442" }
		}
	},
	UltraNightmareWave5 = {
		Dialogue = {
			{ Image = "rbxassetid://73890336396638" }
		}
	},
	UltraNightmareWave6 = {
		Dialogue = {
			{ Image = "rbxassetid://101838569872527" }
		}
	},
	UltraNightmareWave7 = {
		Dialogue = {
			{ Image = "rbxassetid://124586839318988" }
		}
	},
	UltraNightmareWave8 = {
		Dialogue = {
			{ Image = "rbxassetid://121850813456364" }
		}
	},
	UltraNightmareWave9 = {
		Dialogue = {
			{ Image = "rbxassetid://86039234251117" }
		}
	}
}