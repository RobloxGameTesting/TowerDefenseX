local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
return {
	IsPVP = true,
	Category = Enums.PowerUpCategories.Offensive,
	Cooldown = 300,
	MinWave = 20,
	MaxUses = 3,
	Speed = 400,
	Altitude = 65,
	EntranceDistance = 750,
	ExitDistance = 2000,
	Attacks = {
		F22Missile = {
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			TowerDamage = 100,
			PathEntityDamage = 1200,
			TowerDamagePercentage = 0.2,
			PathEntityDamagePercentage = 0.3,
			TowerBuffName = Enums.TowerBuffs.PVPAirStrikeBurn,
			SplashRadius = 7,
			ReloadTime = 10000,
			BurstSize = 1,
			BurstInterval = 0.39,
			EnabledTime = 1.1,
			DisabledTime = 2.5,
			ProjectileName = Enums.Projectiles.F22Missile
		}
	}
}