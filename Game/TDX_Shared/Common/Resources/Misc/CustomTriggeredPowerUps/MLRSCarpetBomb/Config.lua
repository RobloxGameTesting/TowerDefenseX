local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
return {
	Speed = 110,
	Altitude = 65,
	EntranceDistance = 500,
	ExitDistance = 2000,
	BombCount = 105,
	StrikeZoneLength = 180,
	StrikeZoneWidth = 18,
	DropLeadTime = 0.5,
	DropTimeVariance = 0.04,
	Damage = 2175,
	DamageType = Enums.DamageTypes.Explosive,
	ProjectileName = Enums.Projectiles.B52Bomb
}