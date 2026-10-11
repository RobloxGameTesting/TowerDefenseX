local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Parent.AchievementTypes)
return {
	FirstTower = {
		ReadProgressFromDataPath = "TowersPlaced",
		Rewards = {
			{ Type = "Gold", Amount = 50 },
			{ Type = "XP", Amount = 75 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 1
	},
	FirstTowerAbility = {
		ReadProgressFromDataPath = "TowerAbilitiesUsed",
		Rewards = {
			{ Type = "Gold", Amount = 50 },
			{ Type = "XP", Amount = 50 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 5
	},
	AbilitySpammer = {
		ReadProgressFromDataPath = "TowerAbilitiesUsed",
		Rewards = {
			{ Type = "Gold", Amount = 50 },
			{ Type = "XP", Amount = 50 }
		},
		ProgressNeeded = 100,
		PriorityInCategory = 10
	},
	FirstHardMap = {
		ReadProgressFromDataPath = `WinsPerMapDifficulty>{Enums.MapDifficulties.Hard}`,
		Rewards = {
			{ Type = "Gold", Amount = 225 },
			{ Type = "XP", Amount = 450 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 15
	},
	FirstImpossibleMap = {
		ReadProgressFromDataPath = `WinsPerMapDifficulty>{Enums.MapDifficulties.Impossible}`,
		Rewards = {
			{ Type = "Gold", Amount = 300 },
			{ Type = "XP", Amount = 800 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 20
	},
	BeatNightmareMode5Times = {
		ReadProgressFromDataPath = `WinsPerMode>{Enums.Difficulties.Nightmare}`,
		Rewards = {
			{ Type = "Crystals", Amount = 1250 },
			{ Type = "XP", Amount = 20000 }
		},
		ProgressNeeded = 5,
		PriorityInCategory = 21
	}
}