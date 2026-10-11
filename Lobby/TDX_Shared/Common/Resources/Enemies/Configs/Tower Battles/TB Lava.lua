local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Lava",
	Health = 350,
	Speed = 1.7,
	AnimationCalibratedSpeed = 1.7,
	BodyHeat = 9999,
	BodyHeatRegenerationRate = 5000,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 }
	},
	SecondLifeData = { NewDisplayName = "Petrified", NewSpeed = 0, NoCash = true }
}