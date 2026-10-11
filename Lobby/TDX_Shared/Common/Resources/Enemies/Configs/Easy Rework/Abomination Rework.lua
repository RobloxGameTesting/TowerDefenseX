local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Abomination",
	Health = 2850,
	Shield = 1200,
	Speed = 6,
	BodyHeat = 575,
	BodyHeatRegenerationRate = 75,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 6.8,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BigZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.75 }
	}
}