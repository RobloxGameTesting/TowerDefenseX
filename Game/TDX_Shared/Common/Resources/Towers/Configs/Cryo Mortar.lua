local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 15, 8, 5, 4 },
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 1750,
			Health = 300,
			DamageType = Enums.DamageTypes.Ice,
			ProjectileName = Enums.Projectiles.CryoMortarShell,
			IsSplash = true,
			SplashRadius = 4,
			NoAirToGroundSplashTransfer = true,
			SplashAlwaysHitAirAndGround = true,
			Damage = 10,
			ReloadTime = 4,
			Range = 30,
			MinRange = 7,
			StealthDetection = false,
			BodyHeatReduction = 8,
			PermanentSpeedMultiplierIfFrozen = 1,
			DamageMultiplierIfFrozen = 1,
			ThawTimeIfFrozen = _G.DEFAULT_THAW_TIME,
			IgnoreIceResistance = false,
			CanFreezeBoss = false,
			Description = "Base",
			Icon = "rbxassetid://137632240728129"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 650,
				HealthIncrease = 30,
				DamageIncrease = 6,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 5,
				SplashRadiusIncrease = 0,
				BodyHeatReductionIncrease = 4,
				ThawTimeIfFrozenIncrease = 0,
				Description = "Advanced Training",
				Icon = "rbxassetid://112647904923969",
				UpgradeIcon = "rbxassetid://95206287384492"
			},
			{
				Cost = 1500,
				HealthIncrease = 175,
				DamageIncrease = 10,
				SplashRadiusIncrease = 0.5,
				BodyHeatReductionIncrease = 6,
				ThawTimeIfFrozenIncrease = 0,
				Description = "Bigger Shell",
				Icon = "rbxassetid://90296501792417",
				UpgradeIcon = "rbxassetid://84015487122112"
			},
			{
				Cost = 4850,
				HealthIncrease = 400,
				DamageIncrease = 50,
				RangeIncrease = 5,
				SplashRadiusIncrease = 0,
				GainSplashAlwaysHitAirAndGround = true,
				BodyHeatReductionIncrease = 22,
				ThawTimeIfFrozenIncrease = 0,
				ProjectileName = Enums.Projectiles.CryoMortarShellLarge,
				Description = "Nitrogen Shell",
				Icon = "rbxassetid://124428766850614",
				UpgradeIcon = "rbxassetid://73123421951059"
			},
			{
				Cost = 16000,
				HealthIncrease = 1000,
				DamageIncrease = 100,
				ReloadTimeDecrease = 0,
				RangeIncrease = 20,
				SplashRadiusIncrease = 0,
				BodyHeatReductionIncrease = 64,
				ThawTimeIfFrozenIncrease = 0,
				ProjectileName = Enums.Projectiles.CryoMortarShellLarge,
				Description = "Sub-Zero Shell",
				Icon = "rbxassetid://126409640395917",
				UpgradeIcon = "rbxassetid://95957646508850"
			},
			{
				Cost = 50000,
				HealthIncrease = 1000,
				DamageIncrease = 650,
				ReloadTimeDecrease = -2,
				RangeIncrease = 65,
				MinRangeOverride = 15,
				CanFreezeBoss = true,
				SplashRadiusIncrease = 5,
				BodyHeatReductionIncrease = 410,
				ThawTimeIfFrozenIncrease = 0.6,
				ProjectileName = Enums.Projectiles.CryoMortarShellExtraLarge,
				Description = "ICE IS NICE",
				Icon = "rbxassetid://99988900144240",
				UpgradeIcon = "rbxassetid://118224687523312"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	DisplayReloadTime = true,
	AnimationTimeScale = 1,
	NoRestartAttackAnimationIfPlaying = true,
	GunModelName = "Mortar",
	GunModelEffectsDelay = 0,
	MaxObstacleHeight = 10,
	Radius = 2.5,
	HoverHeight = 0.5,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
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
			CostIncreasePerLevel = 125,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 75,
			CostIncreasePerLevel = 50,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Firerate,
			Cost = 325,
			CostIncreasePerLevel = 150,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 275,
			CostIncreasePerLevel = 50,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Freeze,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.1
		}
	}
}