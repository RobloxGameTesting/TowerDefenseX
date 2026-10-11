local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 32000,
	Speed = 3,
	BodyHeat = 5000,
	BodyHeatRegenerationRate = 250,
	Radius = 1.55,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 3.06,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.TumorSummon },
	AbilityBufferTime = 2,
	DeathAbilityNames = { Enums.EnemyAbilities.TumorDeathSummon },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.15 }
	}
}