local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{
		EnemyType = Enums.Enemies.CoffinHeadSpawner,
		Count = 1,
		OnlyBackwardsOffset = true,
		PathStudsOffset = -10,
		NoSpawnTween = true,
		Delay = 4.2
	}
}
return {
	Health = 75000,
	Shield = 50000,
	Speed = 2.5,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 70000,
	BodyHeatRegenerationRate = 5000,
	Radius = 1,
	HasCustomCode = true,
	FootstepEffectInstanceNames = { "RootPart>FootstepSFX" },
	AbilityNames = { Enums.EnemyAbilities.CoffinHeadSlam },
	DeathSpawnData = deathSpawnData,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 1,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.5 }
	}
}