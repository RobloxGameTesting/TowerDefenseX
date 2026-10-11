local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 16000,
	Shield = 10000,
	Speed = 3.2,
	AnimationCalibratedSpeed = 3,
	BodyHeat = 10000,
	BodyHeatRegenerationRate = 2000,
	HasCustomCode = true,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 2,
	FadeOutCustomTime = 1,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.AerialJuggernautMissileAbility },
	DeathAbilityNames = { Enums.EnemyAbilities.AerialJuggernautDeathExplosion },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 }
	}
}