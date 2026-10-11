local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1500,
	Shield = 200,
	Speed = 12.5,
	BodyHeat = 275,
	BodyHeatRegenerationRate = 30,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 10,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.1 }
	}
}