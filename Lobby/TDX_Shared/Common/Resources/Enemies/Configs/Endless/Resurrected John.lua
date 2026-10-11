local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 10000,
	Shield = 2000,
	Speed = 3,
	AnimationCalibratedSpeed = 2,
	BodyHeat = 4000,
	BodyHeatRegenerationRate = 200,
	Radius = 1,
	HoverHeight = 1.365,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.ResurrectedJohnRage },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.1 }
	}
}