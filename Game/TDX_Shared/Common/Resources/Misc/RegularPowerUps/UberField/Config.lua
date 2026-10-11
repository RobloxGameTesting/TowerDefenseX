local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
local Config = {
	BuffName = Enums.TowerBuffs.UberFieldBuff,
	Duration = 30,
	Radius = 14,
	DifficultyOverrides = PowerUpsConfigHandler.ForEachMainDifficulty({ MaxUses = 5 })
}
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Casual] = { MaxUses = 5 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Hard] = { MaxUses = 2 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Voidmare] = { Disabled = true }
return Config