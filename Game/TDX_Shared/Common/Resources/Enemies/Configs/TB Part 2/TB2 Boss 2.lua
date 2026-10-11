local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Boss 2",
	Health = 5000,
	Shield = 500,
	Speed = 2.1,
	NoCash = true,
	BodyHeat = 3500,
	BodyHeatRegenerationRate = 85,
	Radius = 1.33,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.65 }
	}
}