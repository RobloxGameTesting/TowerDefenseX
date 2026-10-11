local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 77,
	Shield = 77,
	Speed = 8,
	BodyHeat = 25,
	BodyHeatRegenerationRate = 2,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 5,
	DeathAbilityNames = { Enums.EnemyAbilities.EgglingSpawnSelfProjectile },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	NoTorso = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 }
	}
}