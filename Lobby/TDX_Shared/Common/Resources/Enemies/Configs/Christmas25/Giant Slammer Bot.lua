local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 50000,
	Shield = 40000,
	Speed = 7.5,
	BodyHeat = 15000,
	BodyHeatRegenerationRate = 3500,
	Radius = 1,
	AnimationTimeScale = 1,
	IsGiantRobot = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GiantRobotDeath1,
	FakeEnemy = false,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	AbilityNames = { Enums.EnemyAbilities.GiantSlammerBotSlam, Enums.EnemyAbilities.GiantSlammerBotBaseSlam },
	AttackData = {},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas25Part1Nightmare] = {
			Health = nil,
			Shield = nil,
			StealthDetection = nil
		},
		[Enums.Difficulties.Christmas25Part2Nightmare] = {
			Health = nil,
			Shield = nil,
			StealthDetection = nil
		}
	}
}