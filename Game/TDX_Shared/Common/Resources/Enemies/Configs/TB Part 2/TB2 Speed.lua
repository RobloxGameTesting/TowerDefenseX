local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Speed",
	Health = 100,
	Shield = 100,
	Speed = 7.4,
	BodyHeat = 25,
	BodyHeatRegenerationRate = 2,
	Radius = 0.86,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 7.4,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.3 }
	}
}