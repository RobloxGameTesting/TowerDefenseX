local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 250,
	NoCash = true,
	Speed = 4.7,
	BodyHeat = 100,
	BodyHeatRegenerationRate = 12,
	Radius = 0.87,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 4.1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.5 }
	}
}