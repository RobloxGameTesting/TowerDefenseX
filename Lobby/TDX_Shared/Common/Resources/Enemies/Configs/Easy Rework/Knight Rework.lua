local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Knight",
	Health = 1346,
	Shield = 346,
	Speed = 3.6,
	BodyHeat = 500,
	BodyHeatRegenerationRate = 40,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 3.6,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BigZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.31 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.2 }
	}
}