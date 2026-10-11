local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local Config = {
	Speed = 90,
	Altitude = 65,
	EntranceDistance = 500,
	ExitDistance = 2000,
	BombCount = 240,
	StrikeZoneLength = 340,
	StrikeZoneWidth = 22,
	DropLeadTime = 0.5,
	DropTimeVariance = 0.05,
	Damage = 58500,
	DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
	ProjectileName = Enums.Projectiles.B52Bomb,
	DifficultyOverrides = {}
}
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Casual] = { MaxUses = 3 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Hard] = { MaxUses = 1 }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Nightmare] = { Disabled = true }
Config.DifficultyOverrides[Enums.Difficulties.TBPart2Voidmare] = { Disabled = true }
return Config