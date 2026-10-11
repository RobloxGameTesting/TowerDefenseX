local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 275,
	Speed = 2.7,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 60,
	BodyHeatRegenerationRate = 20,
	Radius = 1,
	AnimationTimeScale = 1,
	DeathAbilityNames = {
		Enums.EnemyAbilities.UngiftedDeathFirerate,
		Enums.EnemyAbilities.UngiftedDeathRange,
		Enums.EnemyAbilities.UngiftedDeathDamage
	},
	DeathAbilitySelectRandom = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 0,
	FadeOutCustomTime = 0,
	FadeOutRemoveDelay = 3,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 }
	}
}