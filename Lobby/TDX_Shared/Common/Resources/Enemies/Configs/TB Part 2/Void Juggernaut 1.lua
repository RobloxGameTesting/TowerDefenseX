local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2500000,
	Shield = 50000,
	Speed = 1.8,
	BodyHeat = 50000,
	BodyHeatRegenerationRate = 900,
	Radius = 5,
	AnimationCalibratedSpeed = 1.5,
	IsBoss = true,
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	RotationOffset = CFrame.Angles(0, 0, 0),
	AbilityNames = { Enums.EnemyAbilities.VoidJuggernaut1GunSweep, Enums.EnemyAbilities.VoidJuggernaut1Clone },
	AbilityBufferTime = 3,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.TBPart2Voidmare] = {
			[Enums.EnemyAbilities.VoidJuggernaut1GunSweep] = { DamageMultiplier = 1.75 }
		}
	},
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 1,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 1,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.45 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 }
	}
}