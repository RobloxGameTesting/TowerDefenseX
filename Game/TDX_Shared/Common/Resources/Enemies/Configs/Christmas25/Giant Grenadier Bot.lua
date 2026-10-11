local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 15000,
	Shield = 5000,
	Speed = 2.4,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 15000,
	BodyHeatRegenerationRate = 2000,
	Radius = 1,
	AnimationTimeScale = 1,
	IsGiantRobot = true,
	HasCustomCode = true,
	AttackData = {
		{
			Description = "Primary",
			ConsiderTargetsWithNoAttack = true,
			CanTargetAir = true,
			IgnoreGround = false,
			CanTargetBase = true,
			CanTargetBaseUsingEndNodes = true,
			PrioritizeBase = false,
			OnlyAttackBase = false,
			IsProjectile = true,
			ProjectileName = Enums.Projectiles.GrenadierGrenadeStickGiant,
			TowerBuffArray = {
				{ TowerBuffName = Enums.TowerBuffs.GiantGrenadierGrenadeDamageDebuff }
			},
			IsSplash = true,
			SplashRadius = 0.5,
			AimTime = 37 / 30,
			AimResetTime = 37 / 30,
			ResetAimAfterEachShot = true,
			Damage = 400,
			ReloadTime = 1.2,
			Range = 20,
			IsBurst = false,
			DifficultyToStatOverrideMap = {
				[Enums.Difficulties.Christmas25Part1Nightmare] = {
					Damage = nil,
					ReloadTime = nil,
					Range = nil,
					MinimumRange = nil,
					IsSplash = nil,
					SplashRadius = nil
				},
				[Enums.Difficulties.Christmas25Part2Nightmare] = {
					Damage = nil,
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
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GiantRobotDeath1,
	AbilityNames = {},
	FakeEnemy = false,
	FootstepEffectInstanceNames = "HumanoidRootPart>FootstepSFX",
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.3 }
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