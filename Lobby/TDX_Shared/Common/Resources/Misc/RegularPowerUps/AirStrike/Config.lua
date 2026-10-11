local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local Config = {
	Speed = 400,
	Altitude = 65,
	EntranceDistance = 750,
	ExitDistance = 2000,
	Attacks = {
		F22Missile = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			Damage = 1500,
			IsSplash = true,
			SplashRadius = 7,
			ReloadTime = 10000,
			BurstSize = 2,
			BurstInterval = 0.39,
			EnabledTime = 1.1,
			DisabledTime = 2.5,
			ProjectileName = Enums.Projectiles.F22Missile
		}
	},
	DifficultyOverrides = {}
}
Config.DifficultyOverrides[Enums.Difficulties.Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.UltraNightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Casual] = { MaxUses = 30 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Hard] = { MaxUses = 15 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Voidmare] = { Disabled = true }
return Config