local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{
		StaticEntityType = Enums.StaticEntities.SlimeAbsorberSplat,
		Count = 1,
		PathStudsOffset = 1.8,
		StaticEntityLifetime = 14
	}
}
return {
	Health = 325,
	Speed = 3,
	AnimationCalibratedSpeed = 2,
	BodyHeat = 10,
	BodyHeatRegenerationRate = 2,
	Radius = 1,
	AbilityNames = { Enums.EnemyAbilities.SlimeAbsorberJump },
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 1,
	DeathEffect = Enums.DeathEffects.RedGloopLarge,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.5 }
	}
}