local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 1, 1, 1, 1 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 1950,
			Health = 600,
			CanTargetAir = true,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 2,
			ReloadTime = 0.15,
			Range = 8,
			StealthDetection = false,
			MovementSpeed = 9,
			IgnoreObstacles = true,
			AbilityNames = {
				Enums.TowerAbilities.HelicopterMoveToLocation,
				Enums.TowerAbilities.HelicopterMoveToPlayer
			},
			Description = "",
			Icon = ""
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 2000,
				HealthIncrease = 100,
				DamageIncrease = 0.5,
				GainStealthDetection = true,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.HelicopterMoveToPlayer,
					Enums.TowerAbilities.HelicopterStealthReveal
				},
				Description = "Stealth Sensor",
				Icon = "",
				UpgradeIcon = "rbxassetid://122730208928363"
			},
			{
				Cost = 2700,
				HealthIncrease = 100,
				DamageIncrease = 1,
				RangeIncrease = 4,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.HelicopterMoveToPlayer,
					Enums.TowerAbilities.ScoutHelicopterRocketsL1,
					Enums.TowerAbilities.HelicopterStealthReveal
				},
				Description = "Rockets",
				Icon = "",
				UpgradeIcon = "rbxassetid://101193217357777"
			},
			{
				Cost = 4550,
				HealthIncrease = 600,
				DamageIncrease = 2,
				MovementSpeedIncrease = 4,
				ReloadTimeDecrease = 0.02,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.HelicopterMoveToPlayer,
					Enums.TowerAbilities.ScoutHelicopterRocketsL2,
					Enums.TowerAbilities.HelicopterStealthReveal
				},
				Description = "Bigger Payload",
				Icon = "",
				UpgradeIcon = "rbxassetid://81057015641796"
			},
			{
				Cost = 6500,
				HealthIncrease = 2800,
				RangeIncrease = 11,
				DamageIncrease = 4.5,
				ReloadTimeDecrease = 0.01,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.HelicopterMoveToPlayer,
					Enums.TowerAbilities.ScoutHelicopterRocketsL3,
					Enums.TowerAbilities.HelicopterStealthReveal
				},
				Description = "Extended Radar",
				Icon = "",
				UpgradeIcon = "rbxassetid://87875766293274"
			},
			{
				Cost = 24000,
				HealthIncrease = 4000,
				DamageIncrease = 20,
				RangeIncrease = 7,
				MovementSpeedIncrease = 7,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.HelicopterMoveToPlayer,
					Enums.TowerAbilities.ScoutHelicopterBomb,
					Enums.TowerAbilities.HelicopterStealthReveal
				},
				Description = "V-OSPREY",
				Icon = "",
				UpgradeIcon = "rbxassetid://78827478974230"
			}
		}
	},
	HelicopterMovement = true,
	HelicopterCrashData = {
		RandomRadius = 12,
		SplashRadius = 6,
		Duration = 2.5,
		DurationVariance = 0.5,
		DamageData = {
			LowerBoundBase = 200,
			LowerBoundMultiplier = 50,
			UpperBoundBase = 300,
			UpperBoundMultiplier = 200
		},
		ExplosionEffectName = Enums.VisualEffects.ApexPredatorMissileHit
	},
	IsMechanical = true,
	PlacementType = Enums.PlacementTypes.Air,
	EMPVulnerable = true,
	AnimationTimeScale = 1,
	GunModelName = "Weapons",
	HasCustomCode = true,
	Radius = 0.5,
	HoverHeight = _G.AIR_TOWER_HOVER_HEIGHT,
	HoverHeightVariance = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	BuffEffectScale = 2,
	UseMovingRangeCircle = true,
	NoBuffs = true,
	NoHeal = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 100,
			CostIncreasePerLevel = 150,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 400,
			CostIncreasePerLevel = 600,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 175,
			CostIncreasePerLevel = 100,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.MovementSpeed,
			Cost = 75,
			CostIncreasePerLevel = 25,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 20,
			CostIncreasePerLevel = 10,
			Amount = 0.1
		}
	},
	TowerUpgradeShopTabIcon = "rbxassetid://106091112418329"
}