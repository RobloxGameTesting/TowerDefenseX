local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1250,
	Speed = 2.4,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 10,
	BodyHeatRegenerationRate = 2,
	OverrideDisplayName = "Mini Slime Golem",
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GreenGloopSmall,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.1 }
	}
}