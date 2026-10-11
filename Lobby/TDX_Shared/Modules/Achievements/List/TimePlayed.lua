require(script.Parent.Parent.AchievementTypes)
return {
	Time1 = {
		ReadProgressFromDataPath = "GameplayTime",
		Rewards = {
			{ Type = "Gold", Amount = 75 },
			{ Type = "XP", Amount = 75 }
		},
		ProgressNeeded = 3600,
		DisplayDivisor = 3600,
		PriorityInCategory = 1
	},
	Time2 = {
		ReadProgressFromDataPath = "GameplayTime",
		Rewards = {
			{ Type = "Gold", Amount = 100 },
			{ Type = "XP", Amount = 75 }
		},
		ProgressNeeded = 18000,
		DisplayDivisor = 3600,
		PriorityInCategory = 5
	},
	Time3 = {
		ReadProgressFromDataPath = "GameplayTime",
		Rewards = {
			{ Type = "Gold", Amount = 175 },
			{ Type = "XP", Amount = 100 }
		},
		ProgressNeeded = 36000,
		DisplayDivisor = 3600,
		PriorityInCategory = 10
	},
	Time4 = {
		ReadProgressFromDataPath = "GameplayTime",
		Rewards = {
			{ Type = "Gold", Amount = 250 },
			{ Type = "XP", Amount = 150 }
		},
		ProgressNeeded = 90000,
		DisplayDivisor = 3600,
		PriorityInCategory = 15
	},
	Time5 = {
		ReadProgressFromDataPath = "GameplayTime",
		Rewards = {
			{ Type = "Gold", Amount = 500 },
			{ Type = "XP", Amount = 300 }
		},
		ProgressNeeded = 180000,
		DisplayDivisor = 3600,
		PriorityInCategory = 20
	},
	Time6 = {
		ReadProgressFromDataPath = "GameplayTime",
		Rewards = {
			{ Type = "Gold", Amount = 1000 },
			{ Type = "XP", Amount = 600 }
		},
		ProgressNeeded = 360000,
		DisplayDivisor = 3600,
		PriorityInCategory = 25
	},
	Time7 = {
		ReadProgressFromDataPath = "GameplayTime",
		Rewards = {
			{ Type = "Gold", Amount = 1500 },
			{ Type = "XP", Amount = 2250 }
		},
		ProgressNeeded = 604800,
		DisplayDivisor = 3600,
		PriorityInCategory = 30
	},
	Time8 = {
		ReadProgressFromDataPath = "GameplayTime",
		Rewards = {
			{ Type = "Gold", Amount = 2500 },
			{ Type = "XP", Amount = 5000 }
		},
		ProgressNeeded = 2592000,
		DisplayDivisor = 3600,
		PriorityInCategory = 35
	},
	Time9 = {
		ReadProgressFromDataPath = "GameplayTime",
		Rewards = {
			{ Type = "Gold", Amount = 3500 },
			{ Type = "XP", Amount = 25000 }
		},
		ProgressNeeded = 31536000,
		DisplayDivisor = 3600,
		PriorityInCategory = 40
	}
}