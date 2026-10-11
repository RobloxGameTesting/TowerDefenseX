local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Ravager",
	Health = 175000,
	Shield = 100000,
	Speed = 1.7,
	AnimationCalibratedSpeed = 1.9,
	BodyHeat = 80000,
	BodyHeatRegenerationRate = 20000,
	Radius = 3,
	HoverHeight = 2.971,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.3,
	AnimationDefaultStopFadeTime = 0.2,
	StunResistance = true,
	SuperStunResistance = true,
	IsBoss = true,
	BossMusicName = "DreadnoughtBossMusic",
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	AttackData = {
		{
			Description = "Primary",
			CanTargetAir = false,
			IgnoreGround = false,
			CanTargetBase = true,
			CanTargetBaseUsingEndNodes = true,
			PrioritizeBase = true,
			OnlyAttackBase = false,
			TargetMinimumValue = 0,
			ConsiderTargetsWithNoAttack = true,
			ActivateAbilityHandlerBufferTime = true,
			IsProjectile = false,
			IsSplash = false,
			IsPiercing = true,
			PierceCount = 10,
			PierceRange = 15,
			AimTime = 0.5,
			AimResetTime = 10000,
			ResetAimAfterEachShot = false,
			Damage = 300,
			ReloadTime = 0.2,
			Range = 9,
			IsBurst = false,
			DifficultyToStatOverrideMap = {
				[Enums.Difficulties.HalloweenNightmarePart3] = {
					Damage = 600,
					ReloadTime = nil,
					Range = nil,
					MinimumRange = nil,
					IsSplash = nil,
					SplashRadius = nil
				}
			}
		}
	},
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = false,
	GunModelName = "Flamethrower",
	ClientsideAttackTargetTorsoPosition = true,
	NoRestartAttackAnimationIfPlaying = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.DreadnoughtDeath,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	DamageReductionTable = {},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = { Health = 225000, Shield = 320000 }
	}
}