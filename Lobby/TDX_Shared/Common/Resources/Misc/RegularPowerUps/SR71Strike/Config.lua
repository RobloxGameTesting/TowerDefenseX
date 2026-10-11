local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("DamageTypes"))
require(script.Parent.Types)
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
local stunData = {
	StunType = Enums.StunTypes.SR71StrikeStun,
	StunDuration = 20,
	CanStunBoss = true,
	IgnoreStunResistance = true
}
local Config = {
	Speed = 500,
	Altitude = 110,
	EntranceDistance = 1500,
	ExitDistance = 2500,
	Attacks = {
		SR71StrikeMissile = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			Damage = 5000,
			IsSplash = true,
			SplashRadius = 7,
			ReloadTime = 10000,
			BurstSize = 1,
			BurstInterval = 0.39,
			EnabledTime = 2.1,
			DisabledTime = 3.5,
			ProjectileName = Enums.Projectiles.SR71StrikeMissile,
			StunData = stunData
		}
	},
	DifficultyOverrides = PowerUpsConfigHandler.ForEachMainDifficulty({ MaxUses = 2 })
}
Config.DifficultyOverrides[Enums.Difficulties.Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.UltraNightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Casual] = { MaxUses = 3 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Hard] = { MaxUses = 1 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Voidmare] = { Disabled = true }
return Config