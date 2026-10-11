local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 57,
	Shield = 12634,
	NoCash = true,
	Speed = 3.4,
	BodyHeat = 50,
	BodyHeatRegenerationRate = 1,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 3.4,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Toxic, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.3 }
	}
}