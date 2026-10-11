local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
TDX_Shared:WaitForChild("Common")
local Enums = require(TDX_Shared.Common.Enums)
require(TDX_Shared.Modules.Util)
require(script.Parent.Parent.AchievementTypes)
local TB2 = {}

if _G.TB2_EVENT_ENABLED then
	TB2.BeatTB2 = {
		ReadProgressFromDataPath = `WinsPerMode>{Enums.Difficulties.TBPart2Hard}`,
		Rewards = {
			{ Type = "Crystals", Amount = 450 },
			{ Type = "XP", Amount = 10000 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 1
	}
	TB2.BeatTB2Nightmare = {
		ReadProgressFromDataPath = `WinsPerMode>{Enums.Difficulties.TBPart2Nightmare}`,
		Rewards = {
			{ Type = "Crystals", Amount = 550 },
			{ Type = "XP", Amount = 12000 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 2
	}
	TB2.BeatTB2Voidmare = {
		ReadProgressFromDataPath = `WinsPerMode>{Enums.Difficulties.TBPart2Voidmare}`,
		Rewards = {
			{ Type = "Skin", Item = "Phaser_Void" },
			{ Type = "NameTagEffect", Item = "VoidmareGeneralLeah" },
			{ Type = "XP", Amount = 10000 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 3
	}
end

return TB2