local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 1000,
	Speed = 5,
	BodyHeat = 1200,
	BodyHeatRegenerationRate = 400,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.RobotDeath1,
	FakeEnemy = false,
	AttackData = {
		{
			Description = "Primary",
			CanTargetBase = true,
			CanTargetBaseUsingEndNodes = true,
			PrioritizeBase = true,
			OnlyAttackBase = true,
			CanTargetAir = true,
			IsProjectile = false,
			IsSplash = false,
			Damage = 3.5,
			ReloadTime = 1,
			Range = 11,
			IsBurst = true,
			BurstSize = 7,
			BurstInterval = 1 / 6,
			BurstNotInterruptable = true
		}
	},
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	NoRestartAttackAnimationIfPlaying = true,
	GunModelName = "Turret",
	DamageReductionTable = {},
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