local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("ProjectileTypes"))
local baseLevelData = {
	Cost = 600,
	Health = 100,
	DamageType = Enums.DamageTypes.Explosive,
	ProjectileName = Enums.Projectiles.GoldenMine,
	TargetRandomLocationOnPath = true,
	SpawnStaticEntityName = Enums.StaticEntities.GoldenMine,
	DamageStatsTransferredToStaticEntity = true,
	StaticEntityLifetime = 35,
	IsSplash = true,
	SplashRadius = 2.5,
	Damage = 40,
	ReloadTime = 15.5,
	Range = 5,
	StealthDetection = true,
	Description = "Base",
	Icon = "rbxassetid://119435618678223"
}
local path1Data = {
	{
		Cost = 500,
		HealthIncrease = 50,
		StaticEntityLifetimeIncrease = 7.5,
		DamageIncrease = 0,
		ReloadTimeDecrease = 2.5,
		RangeIncrease = 0,
		Description = "Faster Arming",
		Icon = "rbxassetid://77085198103295",
		UpgradeIcon = "rbxassetid://107999086537589"
	},
	{
		Cost = 1750,
		HealthIncrease = 100,
		DamageIncrease = 25,
		ReloadTimeDecrease = 3.5,
		RangeIncrease = 0,
		Description = "Advanced Training",
		Icon = "rbxassetid://113758073954266",
		UpgradeIcon = "rbxassetid://107703480063915"
	},
	{
		Cost = 5000,
		HealthIncrease = 575,
		StaticEntityLifetimeIncrease = 0,
		DamageIncrease = 70,
		ReloadTimeDecrease = 1,
		RangeIncrease = 0,
		SplashRadiusIncrease = 1.5,
		AbilityNames = { Enums.TowerAbilities.GoldenMineLayerCrossbow1 },
		Description = "Crossbow",
		Icon = "rbxassetid://77711788821806",
		UpgradeIcon = "rbxassetid://115233731415107"
	},
	{
		Cost = 8500,
		HealthIncrease = 850,
		StaticEntityLifetimeIncrease = 0,
		DamageIncrease = 85,
		ReloadTimeDecrease = 2,
		RangeIncrease = 0,
		SplashRadiusIncrease = 0,
		AbilityNames = { Enums.TowerAbilities.GoldenMineLayerCrossbow2 },
		Description = "Faster Reload",
		Icon = "rbxassetid://76109449522891",
		UpgradeIcon = "rbxassetid://109506156718203"
	},
	{
		Cost = 13250,
		HealthIncrease = 1800,
		StaticEntityLifetimeIncrease = 0,
		DamageIncrease = 160,
		ReloadTimeDecrease = 1,
		RangeIncrease = 3,
		SplashRadiusIncrease = 2,
		GainSplashAlwaysHitAirAndGround = true,
		AbilityNames = { Enums.TowerAbilities.GoldenMineLayerCrossbow3 },
		Description = "S-Crossbow",
		Icon = "rbxassetid://135856169027122",
		UpgradeIcon = "rbxassetid://137067601130633"
	}
}
local v = {
	Cost = 8500,
	HealthIncrease = 525,
	DamageIncrease = 165,
	StaticEntityLifetimeIncrease = 45,
	RangeIncrease = 0,
	Description = "X Fire Mine",
	Icon = "rbxassetid://81573564601819",
	UpgradeIcon = "rbxassetid://126688469536994",
	BurnEffectStats = {
		Name = Enums.BurnEffects.RedThermite,
		DamageType = Enums.DamageTypes.Fire,
		DamagePerSecond = 10,
		Radius = 3.5,
		Duration = 5,
		StickDuration = 10
	}
}
local v2 = {
	Cost = 18000,
	HealthIncrease = 1050,
	DamageIncrease = 300,
	StaticEntityLifetimeIncrease = 30,
	ReloadTimeDecrease = -0,
	RangeIncrease = 0,
	SplashRadiusIncrease = 0,
	GainIgnoreResistance = true,
	Description = "Napalm",
	Icon = "rbxassetid://132389461707009",
	UpgradeIcon = "rbxassetid://71839075152454",
	BurnEffectStats = {
		Name = Enums.BurnEffects.RedThermite,
		DamageType = Enums.DamageTypes.Fire,
		DamagePerSecond = 20,
		Radius = 3.5,
		Duration = 7,
		StickDuration = 14
	}
}
local v3 = {
	Cost = 102000,
	HealthIncrease = 2000,
	DamageIncrease = 725,
	StaticEntityLifetimeIncrease = 22.5,
	RangeIncrease = 0,
	SplashRadiusIncrease = 1,
	StunType = Enums.StunTypes.GoldenMineStun,
	StunDurationIncrease = 1,
	ProjectileName = Enums.Projectiles.GoldenMinePylon,
	AbilityNames = { Enums.TowerAbilities.GoldenMineLayerHandThrow },
	Description = "S-Mine",
	Icon = "rbxassetid://131031911365434",
	UpgradeIcon = "rbxassetid://73819534696119",
	BurnEffectStats = {
		Name = Enums.BurnEffects.RedThermite,
		DamageType = Enums.DamageTypes.Fire,
		DamagePerSecond = 80,
		Radius = 3.5,
		Duration = 8,
		StickDuration = 8
	}
}
return {
	LimitMap = { 30, 20, 16, 13 },
	DifficultyToLimitMapOverride = {
		[Enums.Difficulties.PVP_1V1] = { 22, 12, 9, 8 }
	},
	UpgradePathData = {
		BaseLevelData = baseLevelData,
		PathLockLevel = 3,
		Path1Data = path1Data,
		Path2Data = {
			{
				Cost = 225,
				HealthIncrease = 50,
				StaticEntityLifetimeIncrease = 25,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Life Span",
				Icon = "rbxassetid://77085198103295",
				UpgradeIcon = "rbxassetid://91330633649886"
			},
			{
				Cost = 1800,
				HealthIncrease = 125,
				DamageIncrease = 40,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				SplashRadiusIncrease = 1,
				Description = "HE Mine",
				Icon = "rbxassetid://113758073954266",
				UpgradeIcon = "rbxassetid://107799570013488"
			},
			v,
			v2,
			v3
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "GoldenMine",
	MaxObstacleHeight = 1.6,
	IsGolden = true,
	Radius = 1.5,
	HoverHeight = 1.218,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	PlacementEffectName = Enums.VisualEffects.GoldenPlacement,
	SetUpKeyframeReachedEventForAttack = true,
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 125,
			CostIncreasePerLevel = 125,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 150,
			CostIncreasePerLevel = 150,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 125,
			CostIncreasePerLevel = 175,
			Amount = 0.25
		}
	}
}