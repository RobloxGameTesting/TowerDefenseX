local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.JetTrooperSmallSplashHit,
	TargetTorsoInsteadOfGround = true,
	VarianceXZ = 0.35,
	VarianceY = 0.25
}
return {
	LimitMap = { 14, 7, 5, 4 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 1175,
			Health = 400,
			CanTargetAir = true,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 3.5,
			ReloadTime = 2.55,
			Range = 11,
			StealthDetection = false,
			BurstSize = 10,
			BurstInterval = 0.1,
			BurstNotInterruptable = true,
			MovementSpeed = 9,
			IgnoreObstacles = true,
			AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation },
			Description = "",
			Icon = "rbxassetid://103088283556142"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 225,
				HealthIncrease = 20,
				ReloadTimeDecrease = 0.35,
				AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation },
				Description = "Faster Reload",
				Icon = "rbxassetid://100152030286718",
				UpgradeIcon = "rbxassetid://135484314097293"
			},
			{
				Cost = 700,
				HealthIncrease = 155,
				MovementSpeedIncrease = 6,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				DamageIncrease = 1.5,
				AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation },
				Description = "Better Thrusters",
				Icon = "rbxassetid://138722244361563",
				UpgradeIcon = "rbxassetid://89766607708892"
			},
			{
				Cost = 2000,
				HealthIncrease = 250,
				DamageIncrease = 4,
				GainStealthDetection = true,
				ReloadTimeDecrease = 0.25,
				RangeIncrease = 2,
				AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation },
				Description = "Advanced Sensors",
				Icon = "rbxassetid://92831875084297",
				UpgradeIcon = "rbxassetid://101085835680582"
			},
			{
				Cost = 5250,
				HealthIncrease = 350,
				DamageIncrease = 8,
				ReloadTimeDecrease = 0.2,
				RangeIncrease = 0,
				AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation },
				Description = "+P Ammo",
				Icon = "rbxassetid://102413021350962",
				UpgradeIcon = "rbxassetid://15247048937"
			},
			{
				Cost = 7800,
				HealthIncrease = 700,
				DamageIncrease = 12,
				ReloadTimeDecrease = 0.75,
				MovementSpeedIncrease = 20,
				RangeIncrease = 4.5,
				AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation },
				Description = "Air Defender",
				Icon = "rbxassetid://99878526838438",
				UpgradeIcon = "rbxassetid://83503955260854"
			}
		},
		Path2Data = {
			{
				Cost = 250,
				HealthIncrease = 20,
				RangeIncrease = 3.5,
				AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation },
				Description = "Extended Sensors",
				Icon = "rbxassetid://100152030286718",
				UpgradeIcon = "rbxassetid://79971965655367"
			},
			{
				Cost = 1000,
				HealthIncrease = 100,
				DamageIncrease = 3,
				GainStunImmunity = true,
				AbilityNames = { Enums.TowerAbilities.HelicopterMoveToLocation },
				Description = "Heavy Ammo",
				Icon = "rbxassetid://138722244361563",
				UpgradeIcon = "rbxassetid://15266660711"
			},
			{
				Cost = 4850,
				HealthIncrease = 1000,
				DamageIncrease = 2,
				ReloadTimeDecrease = 1.2,
				RangeIncrease = 0,
				BurstSizeOverride = 12,
				BurstIntervalOverride = 0.0625,
				SplashRadiusIncrease = 0.5,
				DamageType = Enums.DamageTypes.Explosive,
				ClientHitEffectData = clientHitEffectData,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.JetTrooperFireRoundsL1
				},
				Description = "Explosive Ammo",
				Icon = "rbxassetid://71756179703467",
				UpgradeIcon = "rbxassetid://95013296692186"
			},
			{
				Cost = 15000,
				HealthIncrease = 350,
				DamageIncrease = 11,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				MovementSpeedIncrease = 1,
				BurstSizeOverride = 12,
				BurstIntervalOverride = 0.0625,
				SplashRadiusIncrease = 0,
				ClientHitEffectData = clientHitEffectData,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.JetTrooperFireRoundsL2
				},
				Description = "Incendiary+ Ammo",
				Icon = "rbxassetid://117542049898059",
				UpgradeIcon = "rbxassetid://74653204359776"
			},
			{
				Cost = 31750,
				HealthIncrease = 1200,
				DamageIncrease = 18,
				ReloadTimeDecrease = 0.2,
				BurstSizeOverride = 12,
				BurstIntervalOverride = 0.0625,
				SplashRadiusIncrease = 0.5,
				ClientHitEffectData = clientHitEffectData,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToLocation,
					Enums.TowerAbilities.JetTrooperFireRoundsL3
				},
				Description = "X-Jet Suit",
				Icon = "rbxassetid://90193059863758",
				UpgradeIcon = "rbxassetid://99338026708603"
			}
		}
	},
	HelicopterMovement = true,
	HelicopterCrashData = {
		RandomRadius = 8,
		SplashRadius = 4,
		Duration = 1.4,
		DurationVariance = 0.1,
		DamageData = {
			LowerBoundBase = 100,
			LowerBoundMultiplier = 25,
			UpperBoundBase = 150,
			UpperBoundMultiplier = 100
		},
		ExplosionEffectName = Enums.VisualEffects.JetTrooperDeathExplosion
	},
	IsMechanical = true,
	PlacementType = Enums.PlacementTypes.Air,
	IgnoreAirPlacementLimit = true,
	EMPVulnerable = true,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	NoRestartAttackAnimationIfPlaying = true,
	GunModelName = "Gun",
	HasCustomCode = true,
	Radius = 0.5,
	DirectShieldRadius = 1.5,
	DirectShieldOffset = vector.create(0, -0.5, 0),
	HoverHeight = 0.7 * _G.AIR_TOWER_HOVER_HEIGHT,
	HoverHeightVariance = 0.6,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	UseMovingRangeCircle = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 150,
			CostIncreasePerLevel = 50,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 225,
			CostIncreasePerLevel = 125,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 175,
			CostIncreasePerLevel = 115,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.MovementSpeed,
			Cost = 100,
			CostIncreasePerLevel = 20,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 50,
			CostIncreasePerLevel = 20,
			Amount = 0.1
		}
	}
}