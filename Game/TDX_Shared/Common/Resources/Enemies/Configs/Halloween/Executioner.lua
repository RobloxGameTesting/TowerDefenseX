local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1750,
	Speed = 1.9,
	SuperStunResistance = true,
	AnimationCalibratedSpeed = 1.4,
	BodyHeat = 800,
	BodyHeatRegenerationRate = 300,
	Radius = 1,
	HoverHeight = 2.142,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.ExecutionerSlam },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.95 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 }
	}
}