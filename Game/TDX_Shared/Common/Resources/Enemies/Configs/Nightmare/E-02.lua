local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 19000,
	Shield = 20000,
	Speed = 5.2,
	BodyHeat = 5999,
	BodyHeatRegenerationRate = 800,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FakeEnemy = false,
	AbilityNames = {
		Enums.EnemyAbilities.E02SlowDown,
		Enums.EnemyAbilities.E02Burst,
		Enums.EnemyAbilities.E02Burst_PathEntities
	},
	AbilityBufferTime = 1,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.95 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.9 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.85 }
	},
	FootstepEffectInstanceNames = "HumanoidRootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.UltraNightmare] = {
			[Enums.EnemyAbilities.E02Burst] = { DamageMultiplier = 2 }
		}
	}
}