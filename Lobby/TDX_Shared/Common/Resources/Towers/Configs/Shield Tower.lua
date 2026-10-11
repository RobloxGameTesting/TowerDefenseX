local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AttackDisabled = true,
	DisplayShieldRefreshTime = true,
	LimitMap = { 6, 4, 3, 3 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 4000,
			Health = 2500,
			CanRebuild = true,
			RebuildTime = 10,
			RebuildTimeIncreaseEachDeath = 10,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 0,
			ReloadTime = 1,
			Range = 6,
			StealthDetection = false,
			ShieldSharedGrant = 5000,
			ShieldGrantRefreshTime = 52,
			NearbyTowerHealPerSecond = 0,
			PlacementDisplayDashedRange = true,
			IgnoreObstacles = true,
			Description = "",
			Icon = "rbxassetid://105563514559004"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 1850,
				HealthIncrease = 250,
				RangeIncrease = 5,
				ShieldGrantRefreshTimeDecrease = 0,
				Description = "More Range",
				Icon = "rbxassetid://75878907037474",
				UpgradeIcon = "rbxassetid://117682145322483"
			},
			{
				Cost = 2000,
				HealthIncrease = 100,
				ShieldSharedGrantIncrease = 0,
				ShieldGrantRefreshTimeDecrease = 12,
				Description = "Faster Regen",
				Icon = "rbxassetid://105604750166471",
				UpgradeIcon = "rbxassetid://101240256014491"
			},
			{
				Cost = 13000,
				HealthIncrease = 100,
				ShieldSharedGrantIncrease = 6000,
				ShieldGrantRefreshTimeDecrease = 0,
				Description = "Shield+",
				Icon = "rbxassetid://96515739262793",
				UpgradeIcon = "rbxassetid://120123488831990"
			},
			{
				Cost = 27500,
				HealthIncrease = 400,
				ShieldSharedGrantIncrease = 8000,
				ShieldGrantRefreshTimeDecrease = 0,
				Description = "System Reboot",
				AbilityNames = { Enums.TowerAbilities.ShieldTowerUnstunFieldL1 },
				Icon = "rbxassetid://115561280948073",
				UpgradeIcon = "rbxassetid://121725549298365"
			},
			{
				Cost = 175000,
				HealthIncrease = 2500,
				ShieldSharedGrantIncrease = 30000,
				RangeIncrease = 1,
				ShieldGrantRefreshTimeDecrease = 0,
				Description = "X-Shield Generator",
				AbilityNames = { Enums.TowerAbilities.ShieldTowerUnstunFieldL2 },
				Icon = "rbxassetid://124299293152104",
				UpgradeIcon = "rbxassetid://120565602464865"
			}
		},
		Path2Data = {
			{
				Cost = 1500,
				HealthIncrease = 100,
				ShieldSharedGrantIncrease = 0,
				ShieldGrantRefreshTimeDecrease = 7,
				Description = "Advanced Repairs",
				Icon = "rbxassetid://75878907037474",
				UpgradeIcon = "rbxassetid://131513784508971"
			},
			{
				Cost = 2000,
				HealthIncrease = 250,
				ShieldSharedGrantIncrease = 750,
				RangeIncrease = 1,
				ShieldGrantRefreshTimeDecrease = 3,
				Description = "Internal Upgrades",
				Icon = "rbxassetid://105604750166471",
				UpgradeIcon = "rbxassetid://11425688567"
			},
			{
				Cost = 16000,
				HealthIncrease = 250,
				RangeIncrease = 0,
				ShieldSharedGrantRemove = true,
				ShieldDirectGrantIncrease = 650,
				ShieldGrantRefreshTimeDecrease = 15,
				Description = "Nano Shields",
				Icon = "rbxassetid://119216743218833",
				UpgradeIcon = "rbxassetid://99727366465859"
			},
			{
				Cost = 65000,
				HealthIncrease = 2000,
				RangeIncrease = 2,
				ShieldDirectGrantIncrease = 1900,
				ShieldGrantRefreshTimeDecrease = 2,
				NearbyTowerHealPerSecondIncrease = 100,
				Description = "Passive Healing",
				Icon = "rbxassetid://108948029320752",
				UpgradeIcon = "rbxassetid://126781402931419"
			},
			{
				Cost = 120000,
				HealthIncrease = 3000,
				RangeIncrease = 1,
				ShieldDirectGrantIncrease = 3500,
				ShieldGrantRefreshTimeDecrease = 4,
				NearbyTowerHealPerSecondIncrease = 200,
				Description = "X-Nano Shields",
				Icon = "rbxassetid://133728031879744",
				UpgradeIcon = "rbxassetid://120565602464865"
			}
		}
	},
	IsMechanical = true,
	MaximumRebuilds = 2,
	RebuildVFX = Enums.VisualEffects.ShieldTowerRebuilding,
	RebuildVFXOffset = vector.create(0, 0.3, 0),
	DeathEffect = Enums.DeathEffects.ShieldTowerDeath,
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	NoAnimations = true,
	HasCustomCode = true,
	Radius = 3.2,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	BuffEffectScale = 1.5,
	RangeNoFill = true,
	NoHeal = true,
	PlacementEffectName = Enums.VisualEffects.ShieldTowerPlacement,
	OverrideDisplayStats = {
		"ShieldSharedGrant",
		"ShieldDirectGrant",
		"ShieldGrantRefreshTime",
		"NearbyTowerHealPerSecond",
		"Range"
	},
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 150,
			CostIncreasePerLevel = 50,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Shield,
			Cost = 500,
			CostIncreasePerLevel = 350,
			Amount = 0.35
		},
		{
			Type = Enums.TowerUpgradeShopTypes.ShieldRegenSpeed,
			Cost = 275,
			CostIncreasePerLevel = 150,
			Amount = 0.08
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Heal,
			Cost = 500,
			CostIncreasePerLevel = 225,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 300,
			CostIncreasePerLevel = 300,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 75,
			CostIncreasePerLevel = 20,
			Amount = 0.1
		}
	}
}