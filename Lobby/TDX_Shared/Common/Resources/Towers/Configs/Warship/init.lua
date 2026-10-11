local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local P1L3ShipData = require(script:WaitForChild("P1L3ShipData"))
local P1L4ShipData = require(script:WaitForChild("P1L4ShipData"))
local P1L5ShipData = require(script:WaitForChild("P1L5ShipData"))
local P2L3ShipData = require(script:WaitForChild("P2L3ShipData"))
local P2L4ShipData = require(script:WaitForChild("P2L4ShipData"))
local v = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
local v2 = {
	ModelName = "RailgunTurret",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.WarshipRailgunBlast,
	VarianceXZ = 1.5,
	VarianceY = 0.25
}
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 10000,
			Health = 5000,
			DamageType = Enums.DamageTypes.Explosive,
			ProjectileName = Enums.Projectiles.WarshipBaseProjectile,
			IsSplash = true,
			SplashRadius = 3,
			Damage = 225,
			ReloadTime = 4,
			Range = 400,
			StealthDetection = false,
			IgnoreObstacles = true,
			TurretConfigs = { v },
			Description = "BASE",
			Icon = "rbxassetid://15876502289"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 5000,
				HealthIncrease = 100,
				DamageIncrease = 50,
				ReloadTimeDecrease = 0,
				RangeIncrease = 100,
				TurretConfigs = { v },
				Description = "Longer Barrel",
				Icon = "rbxassetid://15876502189",
				UpgradeIcon = "rbxassetid://15910069882"
			},
			{
				Cost = 6800,
				HealthIncrease = 450,
				DamageIncrease = 50,
				SplashRadiusIncrease = 2,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				TurretConfigs = { v },
				Description = "Bigger Shell",
				Icon = "rbxassetid://15876502073",
				UpgradeIcon = "rbxassetid://15910070083"
			},
			{
				Cost = 28000,
				HealthIncrease = 12000,
				ProjectileName = Enums.Projectiles.WarshipP1Projectile,
				DamageIncrease = 70,
				ReloadTimeDecrease = 0,
				RangeIncrease = 25,
				ShipData = P1L3ShipData,
				Description = "Cruiser",
				Icon = "rbxassetid://15876501977",
				UpgradeIcon = "rbxassetid://15910070474"
			},
			{
				Cost = 52000,
				HealthIncrease = 1000,
				ProjectileName = Enums.Projectiles.WarshipP1Projectile,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 25,
				ShipData = P1L4ShipData,
				AbilityNames = { Enums.TowerAbilities.WarshipHellfireMissiles },
				Description = "Missile Turret",
				Icon = "rbxassetid://15876501819",
				UpgradeIcon = "rbxassetid://15910069730"
			},
			{
				Cost = 235000,
				HealthIncrease = 75000,
				ProjectileName = Enums.Projectiles.BattleshipMainGun,
				DamageIncrease = 1200,
				ReloadTimeDecrease = -15,
				RangeIncrease = 610,
				SplashRadiusIncrease = 8,
				ShipData = P1L5ShipData,
				Description = "Battleship",
				Icon = "rbxassetid://15876501588",
				UpgradeIcon = "rbxassetid://15910070842"
			}
		},
		Path2Data = {
			{
				Cost = 1000,
				HealthIncrease = 100,
				DamageIncrease = 15,
				ReloadTimeDecrease = 0,
				RangeIncrease = 50,
				TurretConfigs = { v },
				Description = "Precision Targeting",
				Icon = "rbxassetid://15876502189",
				UpgradeIcon = "rbxassetid://15910069601"
			},
			{
				Cost = 3200,
				HealthIncrease = 250,
				DamageIncrease = 0,
				ReloadTimeDecrease = 1,
				RangeIncrease = 0,
				TurretConfigs = { v },
				Description = "Crew Training",
				Icon = "rbxassetid://15876502073",
				UpgradeIcon = "rbxassetid://15910070652"
			},
			{
				Cost = 44000,
				HealthIncrease = 10000,
				ProjectileName = Enums.Projectiles.WarshipP2Projectile,
				DamageIncrease = 90,
				SplashRadiusIncrease = 1,
				GainStealthDetection = true,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				ShipData = P2L3ShipData,
				AbilityNames = { Enums.TowerAbilities.WarshipTomahawkLevel1 },
				Description = "Frigate Carrier",
				Icon = "rbxassetid://15876501902",
				UpgradeIcon = "rbxassetid://15910070275"
			},
			{
				Cost = 55000,
				HealthIncrease = 120,
				ProjectileName = Enums.Projectiles.WarshipP2Projectile,
				DamageIncrease = 100,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				ShipData = P2L4ShipData,
				AbilityNames = { Enums.TowerAbilities.WarshipTomahawkLevel2 },
				Description = "Advanced Missiles",
				Icon = "rbxassetid://15876508821",
				UpgradeIcon = "rbxassetid://15910071028"
			},
			{
				Cost = 285000,
				HealthIncrease = 45000,
				RemoveProjectile = true,
				GainStealth = true,
				RegainStealthIfRevealed = true,
				TimeToRegainStealthOverride = 60,
				DamageIncrease = 15025,
				SplashRadiusIncrease = -2,
				ReloadTimeDecrease = -3,
				RangeIncrease = 400,
				TurretConfigs = { v2 },
				ClientHitEffectData = clientHitEffectData,
				AbilityNames = { Enums.TowerAbilities.WarshipStealthReveal },
				Description = "Railgun Warship",
				Icon = "rbxassetid://15876501482",
				UpgradeIcon = "rbxassetid://15910069477"
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
	BuffEffectScale = 15,
	IsShip = true,
	NoBuffs = true,
	NoHeal = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 50,
			CostIncreasePerLevel = 50,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 450,
			CostIncreasePerLevel = 300,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 5,
			CostIncreasePerLevel = 5,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 250,
			CostIncreasePerLevel = 350,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 40,
			CostIncreasePerLevel = 5,
			Amount = 0.07
		}
	}
}