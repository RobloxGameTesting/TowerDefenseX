require(script.Parent.Parent.AchievementTypes)
return {
	Win1 = {
		ReadProgressFromDataPath = "Wins",
		Rewards = {
			{ Type = "Gold", Amount = 100 },
			{ Type = "XP", Amount = 200 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 1
	},
	Win5 = {
		ReadProgressFromDataPath = "Wins",
		Rewards = {
			{ Type = "Gold", Amount = 150 },
			{ Type = "XP", Amount = 250 }
		},
		ProgressNeeded = 5,
		PriorityInCategory = 2
	},
	Win50 = {
		ReadProgressFromDataPath = "Wins",
		Rewards = {
			{ Type = "Gold", Amount = 250 },
			{ Type = "XP", Amount = 400 }
		},
		ProgressNeeded = 50,
		PriorityInCategory = 5
	},
	Win200 = {
		ReadProgressFromDataPath = "Wins",
		Rewards = {
			{ Type = "Gold", Amount = 500 },
			{ Type = "XP", Amount = 800 }
		},
		ProgressNeeded = 200,
		PriorityInCategory = 10
	},
	Win500 = {
		ReadProgressFromDataPath = "Wins",
		Rewards = {
			{ Type = "Gold", Amount = 1500 },
			{ Type = "XP", Amount = 2000 }
		},
		ProgressNeeded = 500,
		PriorityInCategory = 15
	},
	Win1000 = {
		ReadProgressFromDataPath = "Wins",
		Rewards = {
			{ Type = "Gold", Amount = 4500 },
			{ Type = "XP", Amount = 10000 }
		},
		ProgressNeeded = 1000,
		PriorityInCategory = 20
	}
}