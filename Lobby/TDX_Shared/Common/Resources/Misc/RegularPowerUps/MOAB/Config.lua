local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
local Config = {
	Speed = 150,
	Altitude = 65,
	EntranceDistance = 880,
	ExitDistance = 1500,
	Attacks = {
		MOAB = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			Damage = 350000,
			IsSplash = true,
			SplashRadius = 50,
			ReloadTime = 10000,
			BurstSize = 1,
			BurstInterval = 0.39,
			EnabledTime = 5.1,
			DisabledTime = 6.5,
			ProjectileName = Enums.Projectiles.MOAB
		}
	},
	DifficultyOverrides = PowerUpsConfigHandler.ForEachMainDifficulty({
		MaxUses = 1,
		Attacks = {
			MOAB = { Damage = 260000 }
		}
	})
}
Config.DifficultyOverrides[Enums.Difficulties.Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.UltraNightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Casual] = { MaxUses = 3 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Hard] = { MaxUses = 2 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Voidmare] = { Disabled = true }
return Config