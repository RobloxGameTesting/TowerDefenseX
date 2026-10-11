local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 90000,
	Shield = 25000,
	Speed = 3.5,
	BodyHeat = 15000,
	BodyHeatRegenerationRate = 850,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 3.85,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 2,
	FadeOutCustomTime = 1,
	AbilityNames = { Enums.EnemyAbilities.VoidGuardHammerSlam },
	ForceFaceIntroTime = 0.6,
	ForceFaceOutroTime = 0.7,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.TBPart2Voidmare] = {
			[Enums.EnemyAbilities.VoidGuardHammerSlam] = {
				StartingCooldown = 3,
				Cooldown = 12,
				DamageMultiplier = 1.5
			}
		}
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.95 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.7 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.95 }
	}
}