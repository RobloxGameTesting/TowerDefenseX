local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1250,
	Speed = 2.4,
	BodyHeat = 1500,
	BodyHeatRegenerationRate = 350,
	HasCustomCode = true,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.LavaDeath,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.45 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.1 }
	},
	SecondLifeData = { NewDisplayName = "Petrified Amalgam", NewSpeed = 0, NoCash = true }
}