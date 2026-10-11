local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 16, 8, 6, 5 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 850,
			Health = 175,
			ProjectileName = Enums.Projectiles.FlameTrooperProjectile,
			DamageType = Enums.DamageTypes.Fire,
			Damage = 2,
			ReloadTime = 0.2,
			Range = 5,
			StealthDetection = false,
			PierceCount = 4,
			NoDisplayPierceCount = true,
			ApplyBurnStats = { DamagePerSecond = 1, StickDuration = 5 },
			Description = "",
			Icon = "rbxassetid://119944331948368"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 1150,
				HealthIncrease = 75,
				DamageIncrease = 2.5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				Description = "HOTTER TEMPS",
				Icon = "rbxassetid://83206997174357",
				UpgradeIcon = "rbxassetid://73122193558992",
				ApplyBurnStats = { DamagePerSecond = 2, StickDuration = 5 }
			},
			{
				Cost = 2250,
				HealthIncrease = 150,
				DamageIncrease = 6,
				ReloadTimeDecrease = 0,
				RangeIncrease = 4,
				Description = "BIGGER FLAMETHROWER",
				Icon = "rbxassetid://78789767105735",
				UpgradeIcon = "rbxassetid://102727088688513",
				ApplyBurnStats = { DamagePerSecond = 2, StickDuration = 5 }
			},
			{
				Cost = 5250,
				HealthIncrease = 250,
				DamageIncrease = 7,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "NAPALM",
				Icon = "rbxassetid://139134494510595",
				UpgradeIcon = "rbxassetid://128066922463712",
				ApplyBurnStats = { DamagePerSecond = 6, StickDuration = 6 }
			},
			{
				Cost = 10500,
				HealthIncrease = 450,
				DamageIncrease = 6,
				ReloadTimeDecrease = 0,
				GainStunImmunity = true,
				RangeIncrease = 3,
				Description = "M3 Flamethrower",
				Icon = "rbxassetid://104400791183582",
				UpgradeIcon = "rbxassetid://107481097486785",
				ApplyBurnStats = { DamagePerSecond = 8, StickDuration = 10 },
				ExtraDamageMultiplierIncrease = 0.05,
				ExtraDamageDurationIncrease = 7
			},
			{
				Cost = 30500,
				HealthIncrease = 1450,
				AimTimeOverride = 1.1,
				AimResetTimeOverride = 0.5,
				DamageIncrease = 42,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "EXO-FLAME SUIT",
				Icon = "rbxassetid://132326575669564",
				UpgradeIcon = "rbxassetid://70928484581897",
				ApplyBurnStats = { DamagePerSecond = 15, StickDuration = 10 },
				AbilityNames = { Enums.TowerAbilities.FlameTrooperFireRing },
				ExtraDamageMultiplierIncrease = 0.05
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.25,
	AnimationDefaultStopFadeTime = 0.25,
	NoRestartAttackAnimationIfPlaying = true,
	CanPlayAttackAnimationAgain = true,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.292,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DisallowedBuffTypesMap = {
		[Enums.TowerBuffTypes.Range] = true,
		[Enums.TowerBuffTypes.Range2] = true,
		[Enums.TowerBuffTypes.Range3] = true
	},
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 150,
			CostIncreasePerLevel = 50,
			Amount = 0.4
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 250,
			CostIncreasePerLevel = 125,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 250,
			CostIncreasePerLevel = 125,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 150,
			CostIncreasePerLevel = 50,
			Amount = 0.15
		}
	}
}