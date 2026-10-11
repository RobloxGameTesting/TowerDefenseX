local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
TDX_Shared:WaitForChild("Common")
local Util = require(TDX_Shared.Modules.Util)
require(script.Parent.Parent.AchievementTypes)
return {
	Level1 = {
		ReadProgressFromDataPath = "XP",
		Rewards = {
			{ Type = "Gold", Amount = 100 },
			{ Type = "XP", Amount = 200 }
		},
		ProgressNeeded = Util.LevelToXP(9),
		ConvertProgressToLevel = true,
		BadgeId = 2153897183,
		PriorityInCategory = 1
	},
	Level2 = {
		ReadProgressFromDataPath = "XP",
		Rewards = {
			{ Type = "Gold", Amount = 225 },
			{ Type = "XP", Amount = 400 }
		},
		ProgressNeeded = Util.LevelToXP(23),
		ConvertProgressToLevel = true,
		BadgeId = 2153897191,
		PriorityInCategory = 5
	},
	Level3 = {
		ReadProgressFromDataPath = "XP",
		Rewards = {
			{ Type = "Gold", Amount = 375 },
			{ Type = "XP", Amount = 800 }
		},
		ProgressNeeded = Util.LevelToXP(39),
		ConvertProgressToLevel = true,
		BadgeId = 2153897206,
		PriorityInCategory = 10
	},
	Level4 = {
		ReadProgressFromDataPath = "XP",
		Rewards = {
			{ Type = "Gold", Amount = 1000 },
			{ Type = "XP", Amount = 1200 }
		},
		ProgressNeeded = Util.LevelToXP(63),
		ConvertProgressToLevel = true,
		BadgeId = 2153897247,
		PriorityInCategory = 15
	},
	Level5 = {
		ReadProgressFromDataPath = "XP",
		Rewards = {
			{ Type = "Gold", Amount = 1500 },
			{ Type = "XP", Amount = 1600 }
		},
		ProgressNeeded = Util.LevelToXP(89),
		ConvertProgressToLevel = true,
		BadgeId = 2153897263,
		PriorityInCategory = 20
	},
	Level6 = {
		ReadProgressFromDataPath = "XP",
		Rewards = {
			{ Type = "Gold", Amount = 1850 },
			{ Type = "XP", Amount = 2400 }
		},
		ProgressNeeded = Util.LevelToXP(99),
		ConvertProgressToLevel = true,
		BadgeId = 2153897272,
		PriorityInCategory = 25
	},
	Level7 = {
		ReadProgressFromDataPath = "XP",
		Rewards = {
			{ Type = "Gold", Amount = 2000 },
			{ Type = "XP", Amount = 3200 }
		},
		ProgressNeeded = Util.LevelToXP(124),
		ConvertProgressToLevel = true,
		BadgeId = 2153897280,
		PriorityInCategory = 30
	},
	Level8 = {
		ReadProgressFromDataPath = "XP",
		Rewards = {
			{ Type = "Gold", Amount = 3000 },
			{ Type = "XP", Amount = 4000 }
		},
		ProgressNeeded = Util.LevelToXP(149),
		ConvertProgressToLevel = true,
		BadgeId = 2153897296,
		PriorityInCategory = 35
	}
}