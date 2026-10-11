local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 425,
	Shield = 200,
	Speed = 3.1,
	BodyHeat = 75,
	BodyHeatRegenerationRate = 6,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 3,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.25 }
	}
}