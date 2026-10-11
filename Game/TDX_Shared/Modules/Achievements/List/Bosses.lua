local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Parent.AchievementTypes)
return {
	KillTutorialBoss = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.EradB}`,
		Rewards = {
			{ Type = "Gold", Amount = 250 },
			{ Type = "XP", Amount = 150 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 1
	},
	KillPlagueDoctor = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.PlagueDoctor}`,
		Rewards = {
			{ Type = "Gold", Amount = 275 },
			{ Type = "XP", Amount = 350 }
		},
		ProgressNeeded = 1,
		BadgeId = 2153897158,
		PriorityInCategory = 2
	},
	KillPlagueDoctor2 = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.PlagueDoctor}`,
		Rewards = {
			{ Type = "Gold", Amount = 500 },
			{ Type = "XP", Amount = 1000 }
		},
		ProgressNeeded = 6,
		PriorityInCategory = 5
	},
	KillPlagueDoctor3 = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.PlagueDoctor}`,
		Rewards = {
			{ Type = "Gold", Amount = 750 },
			{ Type = "XP", Amount = 2000 }
		},
		ProgressNeeded = 13,
		PriorityInCategory = 7
	},
	KillPredator = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.Predator}`,
		Rewards = {
			{ Type = "Gold", Amount = 175 },
			{ Type = "XP", Amount = 350 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 8
	},
	KillPredator2 = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.Predator}`,
		Rewards = {
			{ Type = "Gold", Amount = 1000 },
			{ Type = "XP", Amount = 2000 }
		},
		ProgressNeeded = 10,
		PriorityInCategory = 9
	},
	KillEradicator = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.Eradicator}`,
		Rewards = {
			{ Type = "Gold", Amount = 400 },
			{ Type = "XP", Amount = 1250 }
		},
		ProgressNeeded = 1,
		BadgeId = 2153897112,
		PriorityInCategory = 10
	},
	KillEradicator2 = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.Eradicator}`,
		Rewards = {
			{ Type = "Gold", Amount = 650 },
			{ Type = "XP", Amount = 1700 }
		},
		ProgressNeeded = 5,
		PriorityInCategory = 11
	},
	KillRevivedPlagueDoctor = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.RevivedPlagueDoctor}`,
		Rewards = {
			{ Type = "Gold", Amount = 550 },
			{ Type = "XP", Amount = 2000 }
		},
		ProgressNeeded = 1,
		BadgeId = 3416298406790691,
		PriorityInCategory = 15
	},
	KillRevivedPlagueDoctor2 = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.RevivedPlagueDoctor}`,
		Rewards = {
			{ Type = "Gold", Amount = 1250 },
			{ Type = "XP", Amount = 2750 }
		},
		ProgressNeeded = 6,
		PriorityInCategory = 16
	},
	KillEradicatorMK2 = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.EradicatorMK2}`,
		Rewards = {
			{ Type = "Gold", Amount = 1000 },
			{ Type = "XP", Amount = 3500 }
		},
		ProgressNeeded = 1,
		BadgeId = 2153897366,
		PriorityInCategory = 20
	},
	KillArtemis = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.Artemis}`,
		Rewards = {
			{ Type = "Gold", Amount = 250 },
			{ Type = "XP", Amount = 750 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 22
	},
	KillZeus = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.Zeus}`,
		Rewards = {
			{ Type = "Gold", Amount = 250 },
			{ Type = "XP", Amount = 750 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 23
	},
	KillPhobeus = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.Phobeus}`,
		Rewards = {
			{ Type = "Gold", Amount = 250 },
			{ Type = "XP", Amount = 750 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 24
	},
	KillDestructor = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.Destructor}`,
		Rewards = {
			{ Type = "Gold", Amount = 750 },
			{ Type = "XP", Amount = 2000 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 25
	},
	KillEradicatorMK2Rework = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.EradicatorMK2Rework}`,
		Rewards = {
			{ Type = "Gold", Amount = 1000 },
			{ Type = "XP", Amount = 4250 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 26
	},
	KillQueen = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.Queen}`,
		Rewards = {
			{ Type = "Gold", Amount = 500 },
			{ Type = "XP", Amount = 1500 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 27
	},
	KillKing = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.King}`,
		Rewards = {
			{ Type = "Gold", Amount = 500 },
			{ Type = "XP", Amount = 1500 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 28
	},
	KillRevivedPlagueDoctorRework = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.RevivedPlagueDoctorRework}`,
		Rewards = {
			{ Type = "Gold", Amount = 1000 },
			{ Type = "XP", Amount = 3500 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 29
	},
	KillX2Trooper = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.X2Trooper}`,
		Rewards = {
			{ Type = "Crystals", Amount = 125 },
			{ Type = "XP", Amount = 10000 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 30
	},
	KillAlphaPredator = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.AlphaPredator}`,
		Rewards = {
			{ Type = "Crystals", Amount = 300 },
			{ Type = "XP", Amount = 25000 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 30
	},
	KillEmperor = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.Emperor}`,
		Rewards = {
			{ Type = "Crystals", Amount = 500 },
			{ Type = "XP", Amount = 35000 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 31
	},
	KillNemesis = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.Nemesis}`,
		Rewards = {
			{ Type = "NameTagEffect", Item = "Calamity" },
			{ Type = "XP", Amount = 20000 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 32
	},
	KillEmperorUltra = {
		ReadProgressFromDataPath = `BossKillMap>{Enums.Enemies.EmperorUltra}`,
		Rewards = {
			{ Type = "NameTagEffect", Item = "Glitch" },
			{ Type = "XP", Amount = 40000 }
		},
		ProgressNeeded = 1,
		PriorityInCategory = 32
	}
}