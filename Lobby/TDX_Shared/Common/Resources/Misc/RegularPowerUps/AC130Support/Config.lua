local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
local Config = {
	EntranceSpeed = 400,
	PylonSpeed = 65,
	ExitSpeed = 300,
	EntranceDistance = 1500,
	ExitDistance = 2500,
	PylonRadius = 170,
	PylonDuration = 45,
	PylonPortAngle = 35,
	PylonAltitute = 120,
	Attacks = {
		Gun105 = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			Damage = 2000,
			SplashRadius = 6,
			ReloadTime = 3.1,
			ExplosionName = Enums.VisualEffects.Gun105Explosion
		},
		Gun40 = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			Damage = 850,
			SplashRadius = 4,
			ReloadTime = 0.7,
			ExplosionName = Enums.VisualEffects.Gun40Explosion
		},
		Gun20_1 = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			Damage = 75,
			SplashRadius = 1,
			ReloadTime = 0.08,
			ExplosionName = Enums.VisualEffects.Gun20Explosion
		},
		Gun20_2 = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			Damage = 75,
			SplashRadius = 1,
			ReloadTime = 0.08,
			ExplosionName = Enums.VisualEffects.Gun20Explosion
		}
	},
	DifficultyOverrides = PowerUpsConfigHandler.ForEachMainDifficulty({
		MaxUses = 2,
		Attacks = {
			Gun105 = { Damage = 2000 },
			Gun40 = { Damage = 567 },
			Gun20_1 = { Damage = 75 },
			Gun20_2 = { Damage = 75 }
		}
	})
}
Config.DifficultyOverrides[Enums.Difficulties.Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.UltraNightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Casual] = { MaxUses = 3 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Hard] = { MaxUses = 1 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Voidmare] = { Disabled = true }
return Config