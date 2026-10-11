local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
local Config = {
	Speed = 2500 / 11,
	DropHeight = 1500,
	EntranceDistanceXZ = 2000,
	KeepTimeAfterHit = 30,
	Damage = 4000000,
	DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
	SplashRadius = 100,
	DifficultyOverrides = PowerUpsConfigHandler.ForEachMainDifficulty({ BossOnly = true })
}
Config.DifficultyOverrides[Enums.Difficulties.Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.UltraNightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Casual] = { MaxUses = 3 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Hard] = { MaxUses = 1 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Voidmare] = { Disabled = true }
return Config