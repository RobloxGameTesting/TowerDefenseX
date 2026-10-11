local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 52750,
	Shield = 45000,
	Speed = 3.2,
	BodyHeat = 6000,
	BodyHeatRegenerationRate = 300,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.8 }
	}
}