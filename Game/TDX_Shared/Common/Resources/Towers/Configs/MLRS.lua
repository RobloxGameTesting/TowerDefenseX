local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local QueryType = require(common:WaitForChild("QueryType"))
local v = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {}
}
local baseLevelData = {
	Cost = 17000,
	Health = 1550,
	DamageType = Enums.DamageTypes.Explosive,
	ProjectileName = Enums.Projectiles.MLRSRocket,
	IsSplash = true,
	SplashRadius = 5,
	SplashAlwaysHitAirAndGround = true,
	Damage = 265,
	ReloadTime = 14,
	Range = 75,
	MinRange = 25,
	StealthDetection = false,
	BurstSize = 6,
	BurstInterval = 1,
	CanTargetAir = false,
	TurretConfigs = { v },
	Description = "",
	Icon = ""
}
local path1Data = {
	{
		Cost = 10400,
		HealthIncrease = 200,
		DamageIncrease = 0,
		ReloadTimeDecrease = 1,
		RangeIncrease = 0,
		MinRangeOverride = 25,
		BurstIntervalOverride = 1,
		BurstSizeIncrease = 6,
		TurretConfigs = { v },
		Description = "Extra Salvo",
		Icon = "",
		UpgradeIcon = "rbxassetid://92848761656514"
	},
	{
		Cost = 4000,
		HealthIncrease = 375,
		DamageIncrease = 0,
		ReloadTimeDecrease = 0,
		RangeIncrease = 50,
		MinRangeOverride = 27,
		BurstIntervalOverride = 1,
		TurretConfigs = { v },
		Description = "Radar",
		Icon = "",
		UpgradeIcon = "rbxassetid://103212595387601"
	},
	{
		Cost = 45000,
		HealthIncrease = 580,
		DamageIncrease = 500,
		RangeIncrease = 0,
		SplashRadiusIncrease = 1,
		MinRangeOverride = 27,
		BurstIntervalOverride = 1,
		TurretConfigs = { v },
		Description = "Heavy Missiles",
		Icon = "",
		UpgradeIcon = "rbxassetid://136950035716848"
	},
	{
		Cost = 12000,
		HealthIncrease = 850,
		ReloadTimeDecrease = 2,
		RangeIncrease = 150,
		MinRangeOverride = 30,
		GainStealthDetection = true,
		BurstIntervalOverride = 1,
		TurretConfigs = { v },
		Description = "Dual Radar",
		Icon = "",
		UpgradeIcon = "rbxassetid://139980195702013"
	},
	{
		Cost = 215000,
		HealthIncrease = 1550,
		DamageIncrease = 1500,
		ReloadTimeDecrease = 1,
		RangeIncrease = 0,
		SplashRadiusIncrease = 2,
		MinRangeOverride = 30,
		BurstIntervalOverride = 1,
		TurretConfigs = { v },
		AbilityNames = { Enums.TowerAbilities.MLRSCarpetBomb },
		Description = "FREEDOM TIME",
		Icon = "",
		UpgradeIcon = "rbxassetid://80361231608908"
	}
}
return {
	LimitMap = { 6, 3, 2, 1 },
	ManualAiming = true,
	ManualAimingAllowAutoTargeting = true,
	ManualAimRetargetAbilityName = Enums.TowerAbilities.ManualAimRetargetMLRS,
	DefaultAimingModeIndex = QueryType.GetManualOptionIndex(),
	DisplayReloadTime = true,
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = baseLevelData,
		PathLockLevel = 3,
		Path1Data = path1Data
	},
	IsMechanical = true,
	DeathEffect = Enums.DeathEffects.XWMTurretDeath,
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	DeathRemoveTextures = true,
	DeathColor = Color3.fromRGB(0, 0, 0),
	DeathMaterial = Enum.Material.CorrodedMetal,
	MaxObstacleHeight = 15,
	Radius = 3.6,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	BuffEffectScale = 2,
	NoBuffs = true,
	NoHeal = true,
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 250,
			CostIncreasePerLevel = 475,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 75,
			CostIncreasePerLevel = 50,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Firerate,
			Cost = 400,
			CostIncreasePerLevel = 375,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 300,
			CostIncreasePerLevel = 300,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 25,
			CostIncreasePerLevel = 10,
			Amount = 0.05
		}
	},
	TowerUpgradeShopTabIcon = "rbxassetid://81234328365522"
}