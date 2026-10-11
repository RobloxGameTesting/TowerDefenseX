local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2250,
	NoCash = true,
	Speed = 4,
	BodyHeat = 8000,
	BodyHeatRegenerationRate = 1000,
	Radius = 1,
	HoverHeight = 1.186,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 }
	}
}