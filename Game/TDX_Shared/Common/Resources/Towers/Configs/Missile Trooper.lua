local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local MissileTrooper = {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 850,
			Health = 100,
			DamageType = Enums.DamageTypes.Explosive,
			ProjectileName = Enums.Projectiles.BasicMissile,
			IsSplash = true,
			SplashRadius = 2,
			Damage = 40,
			ReloadTime = 7.5,
			Range = 20,
			StealthDetection = false,
			Description = "Base",
			Icon = "rbxassetid://13856520902"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 850,
				HealthIncrease = 20,
				DamageIncrease = 35,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				SplashRadiusIncrease = 1,
				Description = "HE Rockets",
				Icon = "rbxassetid://13856520725",
				UpgradeIcon = "rbxassetid://15190600377"
			},
			{
				Cost = 300,
				HealthIncrease = 20,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 5,
				Description = "Optic Sight",
				Icon = "rbxassetid://13856520556",
				UpgradeIcon = "rbxassetid://15190599917"
			},
			{
				Cost = 1800,
				HealthIncrease = 50,
				DamageIncrease = 25,
				PrimaryTargetMultiplierOverride = 1.25,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 4,
				GainStealthDetection = true,
				Description = "SMAW+",
				Icon = "rbxassetid://13856520126",
				UpgradeIcon = "rbxassetid://15190599655"
			},
			{
				Cost = 3250,
				HealthIncrease = 75,
				DamageIncrease = 60,
				PrimaryTargetMultiplierOverride = 1.5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 4,
				Description = "Bigger Warhead",
				Icon = "rbxassetid://13856519740",
				UpgradeIcon = "rbxassetid://15190600617"
			},
			{
				Cost = 12500,
				HealthIncrease = 710,
				ProjectileName = Enums.Projectiles.Javelin,
				PrimaryTargetMultiplierOverride = 3,
				AimTimeOverride = 3,
				ResetAimAfterEachShot = true,
				DamageIncrease = 60,
				ReloadTimeDecrease = 2,
				RangeIncrease = 12,
				GainCanTargetAir = true,
				Description = "JAVELIN",
				Icon = "rbxassetid://13856519278",
				UpgradeIcon = "rbxassetid://15190600257"
			}
		},
		Path2Data = {
			{
				Cost = 240,
				HealthIncrease = 15,
				DamageIncrease = 0,
				ReloadTimeDecrease = 1.25,
				RangeIncrease = 0,
				Description = "Fast Hands",
				Icon = "rbxassetid://13856520725",
				UpgradeIcon = "rbxassetid://15190600483"
			},
			{
				Cost = 260,
				HealthIncrease = 15,
				DamageIncrease = 0,
				ReloadTimeDecrease = 1.25,
				RangeIncrease = 0,
				Description = "Reload Training",
				Icon = "rbxassetid://13856520556",
				UpgradeIcon = "rbxassetid://15190599786"
			},
			{
				Cost = 2400,
				HealthIncrease = 125,
				ProjectileName = Enums.Projectiles.Shell84mm,
				DamageIncrease = 40,
				PrimaryTargetMultiplierOverride = 1.3,
				GainIgnoreResistance = true,
				ReloadTimeDecrease = -1.5,
				RangeIncrease = 0,
				SplashRadiusIncrease = 2,
				Description = "M2 CARL",
				Icon = "rbxassetid://13856520362",
				UpgradeIcon = "rbxassetid://15190600140"
			},
			{
				Cost = 3650,
				HealthIncrease = 175,
				ProjectileName = Enums.Projectiles.Shell84mm,
				DamageIncrease = 85,
				ReloadTimeDecrease = 0,
				PrimaryTargetMultiplierOverride = 1.3,
				SplashRadiusIncrease = 1.5,
				RangeIncrease = 3,
				Description = "Bigger Splash",
				Icon = "rbxassetid://13856519890",
				UpgradeIcon = "rbxassetid://11425688567"
			},
			{
				Cost = 22000,
				HealthIncrease = 900,
				ProjectileName = Enums.Projectiles.MRL,
				DamageIncrease = -100,
				PrimaryTargetMultiplierOverride = 1.3,
				ReloadTimeDecrease = 0,
				RemoveIgnoreResistance = true,
				SplashRadiusIncrease = -3.5,
				GainStealthDetection = true,
				OverrideReloadTime = 0.6,
				Description = "MRL",
				Icon = "rbxassetid://13856519544",
				UpgradeIcon = "rbxassetid://15190600037"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Launcher",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.218,
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0)
}
MissileTrooper.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 75,
		CostIncreasePerLevel = 25,
		Amount = 0.2
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Damage,
		Cost = 150,
		CostIncreasePerLevel = 125,
		Amount = 1
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Range,
		Cost = 125,
		CostIncreasePerLevel = 50,
		Amount = 0.15
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Firerate,
		Cost = 100,
		CostIncreasePerLevel = 50,
		Amount = 0.05
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Splash,
		Cost = 225,
		CostIncreasePerLevel = 100,
		Amount = 0.25
	}
}
return MissileTrooper