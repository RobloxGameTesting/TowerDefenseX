local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 9000,
	Shield = 13750,
	SuperStunResistance = true,
	Speed = 4.5,
	BodyHeat = 3500,
	BodyHeatRegenerationRate = 1000,
	Radius = 1,
	AbilityNames = { Enums.EnemyAbilities.ResurrectedSlammerSlam },
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 }
	}
}