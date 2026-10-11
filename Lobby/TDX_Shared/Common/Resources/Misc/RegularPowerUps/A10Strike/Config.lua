local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
local Config = {
	Speed = 250,
	Altitude = 35,
	EntranceDistance = 2000,
	ExitDistance = 1500,
	Attacks = {
		Minigun = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			Damage = 800,
			IsSplash = true,
			SplashRadius = 1,
			ReloadTime = 0.08,
			EnabledTime = 5.5,
			DisabledTime = 7.1,
			QueryMode = "Strongest"
		},
		WhiteMissile = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			Damage = 2200,
			IsSplash = true,
			SplashRadius = 4,
			ReloadTime = 10000,
			BurstSize = 12,
			BurstInterval = 0.2,
			EnabledTime = 5.2,
			DisabledTime = 7.8,
			ProjectileName = Enums.Projectiles.A10MissileWhite,
			QueryMode = "Random"
		},
		GreenMissile = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			Damage = 2400,
			IsSplash = true,
			SplashRadius = 4,
			ReloadTime = 10000,
			BurstSize = 9,
			BurstInterval = 0.255,
			EnabledTime = 5.3,
			DisabledTime = 7.8,
			ProjectileName = Enums.Projectiles.A10MissileGreen,
			QueryMode = "Random"
		},
		GreenMissileBig = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			Damage = 8000,
			IsSplash = true,
			SplashRadius = 8,
			ReloadTime = 10000,
			BurstSize = 2,
			BurstInterval = 0.2,
			EnabledTime = 7.6,
			DisabledTime = 7.9,
			ProjectileName = Enums.Projectiles.A10MissileGreenBig,
			QueryMode = "Strongest",
			MinimumTargetHP = 55000,
			ApplyFalter = true
		}
	},
	DifficultyOverrides = PowerUpsConfigHandler.ForEachMainDifficulty({
		MaxUses = 1,
		Attacks = {
			Minigun = { Damage = 800 },
			WhiteMissile = { Damage = 1400 },
			GreenMissile = { Damage = 1500 },
			GreenMissileBig = { Damage = 7000 }
		}
	})
}
Config.DifficultyOverrides[Enums.Difficulties.Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.UltraNightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Casual] = { MaxUses = 4 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Hard] = { MaxUses = 2 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Voidmare] = { Disabled = true }
return Config