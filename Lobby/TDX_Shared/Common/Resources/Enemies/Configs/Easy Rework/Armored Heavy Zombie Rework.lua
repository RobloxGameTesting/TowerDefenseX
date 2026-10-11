local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Armored Heavy Zombie",
	Health = 300,
	Shield = 300,
	Speed = 1.8,
	BodyHeat = 150,
	BodyHeatRegenerationRate = 25,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.4,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BigZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 }
	}
}