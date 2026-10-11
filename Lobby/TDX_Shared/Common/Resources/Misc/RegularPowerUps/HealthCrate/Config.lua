local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
local Config = {
	LivesGained = 1000,
	Speed = 50,
	Altitude = 50,
	EntranceDistance = 500,
	ExitDistance = 500,
	DifficultyOverrides = PowerUpsConfigHandler.ForEachMainDifficulty({ MaxUses = 2, MinWave = 10 })
}
Config.DifficultyOverrides[Enums.Difficulties.Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.UltraNightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Casual] = { MaxUses = 5 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Hard] = { MaxUses = 2 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Voidmare] = { Disabled = true }
return Config