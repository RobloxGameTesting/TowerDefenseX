local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
local Config = {
	CashGained = 2400,
	LivesGained = 1500,
	Speed = 50,
	Altitude = 50,
	EntranceDistance = 500,
	ExitDistance = 500,
	DifficultyOverrides = PowerUpsConfigHandler.ForEachMainDifficulty({ MaxUses = 2 })
}
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Casual] = { MaxUses = 4 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Hard] = { MaxUses = 4 }
return Config