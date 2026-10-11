local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "??? Endbringer",
	Health = 250000,
	Shield = 350000,
	Speed = 3.5,
	BodyHeat = 666666,
	BodyHeatRegenerationRate = 66666,
	Radius = 1,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.NightmareEndbringerSlam, Enums.EnemyAbilities.NightmareEndbringerThrow },
	AbilityBufferTime = 2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.4 }
	}
}