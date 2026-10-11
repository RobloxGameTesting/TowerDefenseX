local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 27500,
	Shield = 18000,
	Speed = 2.1,
	BodyHeat = 20000,
	BodyHeatRegenerationRate = 1050,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 1,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 1,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	AbilityNames = { Enums.EnemyAbilities.XJuggernautFlamethrower },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.95 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.45 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.85 }
	},
	PlayerCountToAdditionalStatsMap = {
		[2] = { Shield = 2000 },
		[3] = { Shield = 7000 },
		[4] = { Shield = 20000 }
	}
}