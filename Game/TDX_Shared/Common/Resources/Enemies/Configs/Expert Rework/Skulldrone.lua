local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 70,
	Speed = 2.2,
	BodyHeat = 50,
	BodyHeatRegenerationRate = 15,
	OverrideDisplayName = "Skull Drone",
	Radius = 1,
	HoverHeightVariance = 0.75,
	AnimationDefaultPlayFadeTime = 0.22,
	AnimationDefaultStopFadeTime = 0.22,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AttackData = {
		{
			Description = "Primary",
			ConsiderTargetsWithNoAttack = true,
			CanTargetBase = true,
			CanTargetBaseUsingEndNodes = true,
			PrioritizeBase = false,
			OnlyAttackBase = false,
			IsProjectile = false,
			IsSplash = false,
			AimTime = 0.1,
			AimResetTime = 10000,
			ResetAimAfterEachShot = false,
			Damage = 15,
			DamageDelay = 0.25,
			ReloadTime = 2.1,
			Range = 2.75,
			MinimumRange = 0.75,
			IsBurst = false
		}
	},
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	GunModelName = "Attack",
	GunModelEffectsDelay = 0,
	DamageReductionTable = {}
}