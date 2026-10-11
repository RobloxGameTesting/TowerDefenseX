local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Mr. Saw",
	Health = 550,
	Speed = 2.2,
	AnimationCalibratedSpeed = 2,
	BodyHeat = 175,
	BodyHeatRegenerationRate = 70,
	Radius = 1,
	HoverHeight = 1.549,
	AnimationTimeScale = 1,
	BaseDamageMultiplier = 2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.4 }
	}
}