local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2250,
	Shield = 1500,
	Speed = 2.5,
	BodyHeat = 520,
	BodyHeatRegenerationRate = 25,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	NoTorso = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.5 }
	}
}