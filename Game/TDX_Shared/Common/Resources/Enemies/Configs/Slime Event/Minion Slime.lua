local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 50,
	Shield = 175,
	Speed = 6,
	AnimationCalibratedSpeed = 4,
	BodyHeat = 10,
	BodyHeatRegenerationRate = 2,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.PurpleGloopXtraSmall,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.15 }
	}
}