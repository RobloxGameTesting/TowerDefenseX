require(script.Parent.Parent.AchievementTypes)
return {
	KillZombies1 = {
		ReadProgressFromDataPath = "Kills",
		Rewards = {
			{ Type = "Gold", Amount = 75 },
			{ Type = "XP", Amount = 50 }
		},
		ProgressNeeded = 1000,
		PriorityInCategory = 1
	},
	KillZombies2 = {
		ReadProgressFromDataPath = "Kills",
		Rewards = {
			{ Type = "Gold", Amount = 225 },
			{ Type = "XP", Amount = 400 }
		},
		ProgressNeeded = 10000,
		PriorityInCategory = 5
	},
	KillZombies3 = {
		ReadProgressFromDataPath = "Kills",
		Rewards = {
			{ Type = "Gold", Amount = 400 },
			{ Type = "XP", Amount = 1000 }
		},
		ProgressNeeded = 100000,
		PriorityInCategory = 10
	},
	KillZombies4 = {
		ReadProgressFromDataPath = "Kills",
		Rewards = {
			{ Type = "Gold", Amount = 1250 },
			{ Type = "XP", Amount = 3000 }
		},
		ProgressNeeded = 1000000,
		PriorityInCategory = 15
	},
	KillZombies5 = {
		ReadProgressFromDataPath = "Kills",
		Rewards = {
			{ Type = "Gold", Amount = 2000 },
			{ Type = "XP", Amount = 10000 }
		},
		ProgressNeeded = 10000000,
		PriorityInCategory = 20
	}
}