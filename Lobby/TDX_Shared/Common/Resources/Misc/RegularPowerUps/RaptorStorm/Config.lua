local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
local Config = {
	Count = 30,
	IntervalLowerBound = 0.4,
	IntervalUpperBound = 0.8,
	AngleVariance = 12,
	XZVariance = 75,
	SpeedVariance = 40,
	Speed = 390,
	Altitude = 65,
	EntranceDistance = 900,
	ExitDistance = 2000,
	Attacks = {
		F22Missile = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			Damage = 3500,
			IsSplash = true,
			SplashRadius = 7,
			ReloadTime = 10000,
			BurstSize = 2,
			BurstInterval = 0.39,
			EnabledTime = 1.1,
			DisabledTime = 2.5,
			ProjectileName = Enums.Projectiles.F22Missile,
			QueryMode = "Random"
		}
	},
	DifficultyOverrides = PowerUpsConfigHandler.ForEachMainDifficulty({
		Attacks = {
			F22Missile = { Damage = 2750 }
		},
		MaxUses = 1
	})
}
Config.DifficultyOverrides[Enums.Difficulties.Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.UltraNightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Casual] = { MaxUses = 3 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Hard] = { MaxUses = 1 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Voidmare] = { Disabled = true }
return Config