local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 15000,
	Shield = 15000,
	Speed = 6,
	BodyHeat = 20000,
	BodyHeatRegenerationRate = 1200,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = {
		Enums.EnemyAbilities.RocketDroneAerialShoot,
		Enums.EnemyAbilities.RocketDroneGroundShoot,
		Enums.EnemyAbilities.RocketDroneAllShoot
	},
	AbilityBufferTime = 3,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 }
	}
}