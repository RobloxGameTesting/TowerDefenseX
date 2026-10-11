local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Pathfinder Tank",
	Health = 18000,
	Shield = 1000,
	Speed = 3,
	AnimationCalibratedSpeed = 3,
	BodyHeat = 8000,
	BodyHeatRegenerationRate = 3000,
	Radius = 3,
	HoverHeight = 1.548,
	AnimationTimeScale = 1,
	ReachEndIncludeRadius = true,
	TurretConfigs = {
		{
			ModelName = "Turret",
			RotationConstraintConfig = { CanRotateY = true },
			TurretGunConfigs = {
				{
					ModelName = "Gun",
					RotationOffset = CFrame.Angles(-1.5707963267948966, 3.141592653589793, 0),
					RotationConstraintConfig = {
						CanRotateX = true,
						MaxRotationX = 20,
						MinRotationX = -7
					}
				}
			}
		}
	},
	AttackData = {
		{
			Description = "Primary",
			ClientHitEffectData = {
				EffectName = Enums.VisualEffects.PurpleTankBlast,
				TargetTorsoInsteadOfGround = true,
				VarianceXZ = 0.35,
				VarianceY = 0.25
			},
			CanTargetBase = true,
			CanTargetBaseUsingEndNodes = true,
			PrioritizeBase = false,
			OnlyAttackBase = false,
			TargetMinimumValue = 0,
			ConsiderTargetsWithNoAttack = true,
			IsProjectile = false,
			IsSplash = true,
			SplashRadius = 1,
			Damage = 300,
			ReloadTime = 3,
			Range = 25,
			IsBurst = false,
			DifficultyToStatOverrideMap = {
				[Enums.Difficulties.HalloweenNightmarePart3] = {
					Damage = 2500,
					ReloadTime = 2,
					Range = 35,
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
	ClientsideAttackTargetTorsoPosition = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.VoidTankDeath,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.4 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = { Health = nil, Shield = nil }
	}
}