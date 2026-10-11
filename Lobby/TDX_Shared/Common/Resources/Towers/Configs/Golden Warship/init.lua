local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local GoldenWarshipTurretData = require(script:WaitForChild("GoldenWarshipTurretData"))
local L0ShipData = require(script:WaitForChild("L0ShipData"))
local L1ShipData = require(script:WaitForChild("L1ShipData"))
local L2ShipData = require(script:WaitForChild("L2ShipData"))
local P1L3ShipData = require(script:WaitForChild("P1L3ShipData"))
local P1L4ShipData = require(script:WaitForChild("P1L4ShipData"))
local P1L5ShipData = require(script:WaitForChild("P1L5ShipData"))
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.GoldenWarshipRailgunL3Blast,
	VarianceXZ = 1.5,
	VarianceY = 0.25
}
local clientHitEffectData2 = {
	EffectName = Enums.VisualEffects.GoldenWarshipRailgunL5Blast,
	VarianceXZ = 1.5,
	VarianceY = 0.25
}
local GoldenWarship = {
	LimitMap = { 1, 1, 1, 1 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 375000,
			Health = 60000,
			DamageType = Enums.DamageTypes.Golden,
			ProjectileName = Enums.Projectiles.GoldenWarshipBaseProjectile,
			IsSplash = true,
			SplashRadius = 5,
			Damage = 4000,
			ReloadTime = 3,
			Range = 800,
			StealthDetection = false,
			IgnoreObstacles = true,
			ShipData = L0ShipData,
			TurretConfigs = GoldenWarshipTurretData.L0,
			Description = "TODO",
			Icon = ""
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 100000,
				HealthIncrease = 2000,
				DamageIncrease = 50,
				ReloadTimeDecrease = 0,
				RangeIncrease = 100,
				ShipData = L1ShipData,
				TurretConfigs = GoldenWarshipTurretData.L1,
				Description = "TRIPLE BARREL",
				Icon = "",
				UpgradeIcon = "rbxassetid://126423826265757"
			},
			{
				Cost = 180000,
				HealthIncrease = 450,
				DamageIncrease = 0,
				SplashRadiusIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				ShipData = L2ShipData,
				TurretConfigs = GoldenWarshipTurretData.L2,
				Description = "AA GUNS",
				Icon = "",
				UpgradeIcon = "rbxassetid://110760172396714"
			},
			{
				Cost = 700000,
				HealthIncrease = 12000,
				ProjectileName = Enums.Projectiles.GoldenWarshipP1Projectile,
				DamageIncrease = 70,
				ReloadTimeDecrease = 0,
				RangeIncrease = 25,
				ShipData = P1L3ShipData,
				TurretConfigs = GoldenWarshipTurretData.P1L3,
				AbilityNames = { Enums.TowerAbilities.GoldenWarshipHellfireMissilesL1 },
				Description = "MISSILE TURRET",
				Icon = "",
				UpgradeIcon = "rbxassetid://118943021243132"
			},
			{
				Cost = 450000,
				HealthIncrease = 1000,
				ProjectileName = Enums.Projectiles.GoldenWarshipP1Projectile,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 25,
				ShipData = P1L4ShipData,
				TurretConfigs = GoldenWarshipTurretData.P1L4,
				AbilityNames = { Enums.TowerAbilities.GoldenWarshipHellfireMissilesL2 },
				Description = "GATTLING GUN",
				Icon = "",
				UpgradeIcon = "rbxassetid://119578606857356"
			},
			{
				Cost = 3500000,
				HealthIncrease = 750000,
				ProjectileName = Enums.Projectiles.GoldenWarshipP1MaxProjectile,
				DamageIncrease = 16000,
				ReloadTimeDecrease = -8,
				RangeIncrease = 250,
				SplashRadiusIncrease = 8,
				ShipData = P1L5ShipData,
				TurretConfigs = GoldenWarshipTurretData.P1L5,
				Description = "WARSHIP-X",
				Icon = "",
				UpgradeIcon = "rbxassetid://84014190049880"
			}
		},
		Path2Data = {
			{
				Cost = 67000,
				HealthIncrease = 1000,
				DamageIncrease = 5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 500,
				ShipData = L1ShipData,
				TurretConfigs = GoldenWarshipTurretData.L1,
				Description = "CALAMITY POWER",
				Icon = "",
				UpgradeIcon = "rbxassetid://84862739179110"
			},
			{
				Cost = 90000,
				HealthIncrease = 250,
				DamageIncrease = 70,
				ReloadTimeDecrease = 0.75,
				RangeIncrease = 0,
				ShipData = L2ShipData,
				TurretConfigs = GoldenWarshipTurretData.L2,
				Description = "COOL STUFF",
				Icon = "",
				UpgradeIcon = "rbxassetid://85103871545353"
			},
			{
				Cost = 440000,
				HealthIncrease = 10000,
				DamageIncrease = 8000,
				SplashRadiusIncrease = -2,
				ReloadTimeDecrease = -3,
				RangeIncrease = 0,
				MaximumROMOverride = 270,
				TurretConfigs = GoldenWarshipTurretData.P2L3,
				ClientHitEffectData = clientHitEffectData,
				RemoveProjectile = true,
				Description = "RAILGUN TURRET",
				Icon = "",
				UpgradeIcon = "rbxassetid://82473091607513"
			},
			{
				Cost = 550000,
				HealthIncrease = 120,
				DamageIncrease = 15000,
				SplashRadiusIncrease = 0.5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				MaximumROMOverride = 270,
				TurretConfigs = GoldenWarshipTurretData.P2L4,
				ClientHitEffectData = clientHitEffectData,
				RemoveProjectile = true,
				Description = "BIGGER RAILGUN",
				Icon = "",
				UpgradeIcon = "rbxassetid://101952765445902"
			},
			{
				Cost = 7600000,
				HealthIncrease = 450000,
				DamageIncrease = 758000,
				SplashRadiusIncrease = 4.5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 400,
				GainIgnoreResistance = true,
				RemoveMaximumROM = true,
				TurretConfigs = GoldenWarshipTurretData.P2L5,
				ClientHitEffectData = clientHitEffectData2,
				RemoveProjectile = true,
				Description = "BFG X",
				Icon = "",
				UpgradeIcon = "rbxassetid://99858201497378"
			}
		}
	},
	IsMechanical = true,
	PlacementType = Enums.PlacementTypes.Water,
	AnimationTimeScale = 1,
	OverrideRemoveDelayAfterDeath = 19,
	Radius = 200,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	PlacementEffectName = Enums.VisualEffects.GoldenWarshipPlacement,
	BuffEffectScale = 15,
	IsShip = true,
	NoBuffs = true,
	NoHeal = true,
	PlacementGlobalMessage = "WE ARE BEING REINFORCED WITH A DREADNOUGHT",
	BannedInPVP = true
}
GoldenWarship.TowerUpgradeShopData = {
	{ Type = Enums.TowerUpgradeShopTypes.Health, Cost = 5, CostIncreasePerLevel = 5, Amount = 0.1 },
	{
		Type = Enums.TowerUpgradeShopTypes.Damage,
		Cost = 800,
		CostIncreasePerLevel = 400,
		Amount = 0.25
	},
	{ Type = Enums.TowerUpgradeShopTypes.Range, Cost = 5, CostIncreasePerLevel = 5, Amount = 0.2 },
	{
		Type = Enums.TowerUpgradeShopTypes.Splash,
		Cost = 1000,
		CostIncreasePerLevel = 500,
		Amount = 0.25
	}
}
GoldenWarship.TowerUpgradeShopTabIcon = "rbxassetid://93596820046672"
return GoldenWarship