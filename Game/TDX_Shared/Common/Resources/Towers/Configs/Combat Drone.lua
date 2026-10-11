local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
require(common:WaitForChild("FirstPersonTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Turret",
	AutoWeldToInstanceName = "MainBody",
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Gun",
			RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 25, MinRotationX = -75 }
		}
	}
}
local v2 = {
	ModelName = "Turret",
	AutoWeldToInstanceName = "MainBody",
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Gun",
			RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 25, MinRotationX = -75 },
			RotatingBarrelData = {
				{
					WeldPointerName = "RotatingBarrelWeld",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 0.7,
					TimeToStopRotation = 1.3,
					MaxRotationSpeedX = 20
				}
			}
		}
	}
}
local v3 = {
	ModelName = "RocketTurret",
	AutoWeldToInstanceName = "MainBody",
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Gun",
			RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 25, MinRotationX = -75 }
		}
	}
}
local firstPersonConfig = {
	UIName = "CombatDroneBase",
	PlayerAnimationName = "CombatDroneTablet",
	ZoomOptions = { 80, 55, 30 },
	AttackConfigs = {
		{
			WeaponName = "GUN",
			NoTriggerClientTowerAttacked = true,
			BaseMultiplier = 1.5,
			HeadshotMultiplier = 2.5,
			BossHeadshotMultiplier = 3.5,
			StrongBossHeadshotMultiplier = 5.5,
			HeadshotIgnoreResistance = true,
			HitEffectName = Enums.VisualEffects.MinigunHit,
			DefaultSpreadDegrees = 0.5,
			CrosshairConfig = { Expansion = 8, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.6, -0.25, -0.12),
				CamKickMax = createVector(0.7, -0.1, 0.12),
				CamKickSpeed = 17
			},
			UseHoverHeightForHeadHeight = true
		}
	},
	MovementConfig = {
		LevelStatsMovementSpeedMultiplier = 2,
		VerticalMovementSpeed = 8,
		ColliderDiameter = 11
	}
}
local firstPersonConfig2 = {
	UIName = "CombatDroneBase",
	PlayerAnimationName = "CombatDroneTablet",
	ZoomOptions = { 80, 55, 30 },
	AttackConfigs = {
		{
			WeaponName = "AR",
			NoTriggerClientTowerAttacked = true,
			BaseMultiplier = 1.5,
			HeadshotMultiplier = 2.5,
			BossHeadshotMultiplier = 3.5,
			StrongBossHeadshotMultiplier = 5.5,
			HeadshotIgnoreResistance = true,
			HitEffectName = Enums.VisualEffects.MinigunHit,
			DefaultSpreadDegrees = 0.5,
			CrosshairConfig = { Expansion = 8, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.6, -0.25, -0.12),
				CamKickMax = createVector(0.7, -0.1, 0.12),
				CamKickSpeed = 17
			},
			UseHoverHeightForHeadHeight = true
		}
	},
	MovementConfig = {
		LevelStatsMovementSpeedMultiplier = 2,
		VerticalMovementSpeed = 8,
		ColliderDiameter = 11
	}
}
local firstPersonConfig3 = {
	UIName = "CombatDroneBase",
	PlayerAnimationName = "CombatDroneTablet",
	ZoomOptions = { 80, 55, 30 },
	AttackConfigs = {
		{
			WeaponName = "AR",
			NoTriggerClientTowerAttacked = true,
			BaseMultiplier = 1.5,
			HeadshotMultiplier = 2.5,
			BossHeadshotMultiplier = 3.5,
			StrongBossHeadshotMultiplier = 5.5,
			HeadshotIgnoreResistance = true,
			HitEffectName = Enums.VisualEffects.MinigunHit,
			DefaultSpreadDegrees = 0.5,
			CrosshairConfig = { Expansion = 8, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.6, -0.25, -0.12),
				CamKickMax = createVector(0.7, -0.1, 0.12),
				CamKickSpeed = 17
			},
			UseHoverHeightForHeadHeight = true
		}
	},
	MovementConfig = {
		LevelStatsMovementSpeedMultiplier = 2,
		VerticalMovementSpeed = 8,
		ColliderDiameter = 11
	}
}
local firstPersonConfig4 = {
	UIName = "CombatDroneBase",
	PlayerAnimationName = "CombatDroneTablet",
	ZoomOptions = { 80, 55, 30 },
	AttackConfigs = {
		{
			WeaponName = "MG",
			NoTriggerClientTowerAttacked = true,
			BaseMultiplier = 1.5,
			HeadshotMultiplier = 2.5,
			BossHeadshotMultiplier = 3.5,
			StrongBossHeadshotMultiplier = 5.5,
			HeadshotIgnoreResistance = true,
			HitEffectName = Enums.VisualEffects.MinigunHit,
			DefaultSpreadDegrees = 0.5,
			CrosshairConfig = { Expansion = 8, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.6, -0.25, -0.12),
				CamKickMax = createVector(0.7, -0.1, 0.12),
				CamKickSpeed = 17
			},
			UseHoverHeightForHeadHeight = true
		}
	},
	AbilityNames = { Enums.TowerAbilities.CombatDroneShieldL1 },
	MovementConfig = {
		LevelStatsMovementSpeedMultiplier = 2,
		VerticalMovementSpeed = 8,
		ColliderDiameter = 11
	}
}
local firstPersonConfig5 = {
	UIName = "CombatDroneBase",
	PlayerAnimationName = "CombatDroneTablet",
	ZoomOptions = { 80, 55, 30 },
	AttackConfigs = {
		{
			WeaponName = "MG",
			NoTriggerClientTowerAttacked = true,
			BaseMultiplier = 1.5,
			HeadshotMultiplier = 2.5,
			BossHeadshotMultiplier = 3.5,
			StrongBossHeadshotMultiplier = 5.5,
			HeadshotIgnoreResistance = true,
			HitEffectName = Enums.VisualEffects.MinigunHit,
			DefaultSpreadDegrees = 0.5,
			CrosshairConfig = { Expansion = 8, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.6, -0.25, -0.12),
				CamKickMax = createVector(0.7, -0.1, 0.12),
				CamKickSpeed = 17
			},
			UseHoverHeightForHeadHeight = true
		},
		{
			WeaponName = "RCKT",
			NoTriggerClientTowerAttacked = true,
			UseAbilityName = Enums.TowerAbilities.CombatDroneRocketsP1L4,
			BaseMultiplier = 1.5,
			MagSize = 6,
			ShotInterval = 0.2,
			ReloadTime = 4.5,
			ProjectileMissTravelDistance = 150,
			DefaultSpreadDegrees = 0.5,
			CrosshairConfig = { Expansion = 15, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.6, -0.25, -0.12),
				CamKickMax = createVector(0.7, -0.1, 0.12),
				CamKickSpeed = 17
			},
			UseHoverHeightForHeadHeight = true
		}
	},
	AbilityNames = { Enums.TowerAbilities.CombatDroneShieldL2 },
	MovementConfig = {
		LevelStatsMovementSpeedMultiplier = 2,
		VerticalMovementSpeed = 8,
		ColliderDiameter = 11
	}
}
local firstPersonConfig6 = {
	UIName = "CombatDroneBase",
	PlayerAnimationName = "CombatDroneTablet",
	ZoomOptions = { 80, 55, 30 },
	AttackConfigs = {
		{
			WeaponName = "MG",
			NoTriggerClientTowerAttacked = true,
			BaseMultiplier = 1.5,
			HeadshotMultiplier = 2.5,
			BossHeadshotMultiplier = 3.5,
			StrongBossHeadshotMultiplier = 5.5,
			HeadshotIgnoreResistance = true,
			HitEffectName = Enums.VisualEffects.LaserHit,
			DefaultSpreadDegrees = 0.5,
			CrosshairConfig = { Expansion = 5, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.6, -0.25, -0.12),
				CamKickMax = createVector(0.7, -0.1, 0.12),
				CamKickSpeed = 17
			},
			UseHoverHeightForHeadHeight = true
		},
		{
			WeaponName = "RCKT",
			NoTriggerClientTowerAttacked = true,
			UseAbilityName = Enums.TowerAbilities.CombatDroneRocketsP1L5,
			BaseMultiplier = 1.5,
			MagSize = 12,
			ShotInterval = 0.09,
			ReloadTime = 2.5,
			ProjectileMissTravelDistance = 150,
			DefaultSpreadDegrees = 0.5,
			CrosshairConfig = { Expansion = 15, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.6, -0.25, -0.12),
				CamKickMax = createVector(0.7, -0.1, 0.12),
				CamKickSpeed = 17
			},
			UseHoverHeightForHeadHeight = true
		},
		{
			WeaponName = "BOMB",
			NoTriggerClientTowerAttacked = true,
			UseAbilityName = Enums.TowerAbilities.CombatDroneBomb,
			BaseMultiplier = 1.5,
			MagSize = 3,
			ShotInterval = 1,
			ReloadTime = 8,
			ProjectileMissTravelDistance = 150,
			DefaultSpreadDegrees = 0.5,
			CrosshairConfig = { Expansion = 15, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.6, -0.25, -0.12),
				CamKickMax = createVector(0.7, -0.1, 0.12),
				CamKickSpeed = 17
			},
			UseHoverHeightForHeadHeight = true
		}
	},
	AbilityNames = { Enums.TowerAbilities.CombatDroneShieldL3 },
	MovementConfig = {
		LevelStatsMovementSpeedMultiplier = 2,
		VerticalMovementSpeed = 8,
		ColliderDiameter = 11
	}
}
local firstPersonConfig7 = {
	UIName = "CombatDroneP2",
	PlayerAnimationName = "CombatDroneTablet",
	ZoomOptions = { 80, 55, 30 },
	AttackConfigs = {
		{
			WeaponName = "MSL",
			NoTriggerClientTowerAttacked = true,
			BaseMultiplier = 1.5,
			ProjectileMissTravelDistance = 150,
			DefaultSpreadDegrees = 0.5,
			CrosshairConfig = { Expansion = 15, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.6, -0.25, -0.12),
				CamKickMax = createVector(0.7, -0.1, 0.12),
				CamKickSpeed = 17
			},
			UseHoverHeightForHeadHeight = true
		}
	},
	AbilityNames = { Enums.TowerAbilities.CombatDroneSpotterL1 },
	MovementConfig = { LevelStatsMovementSpeedMultiplier = 2, VerticalMovementSpeed = 8 }
}
local firstPersonConfig8 = {
	UIName = "CombatDroneP2",
	PlayerAnimationName = "CombatDroneTablet",
	ZoomOptions = { 80, 55, 30 },
	AttackConfigs = {
		{
			WeaponName = "MSL",
			NoTriggerClientTowerAttacked = true,
			BaseMultiplier = 1.5,
			ProjectileMissTravelDistance = 150,
			DefaultSpreadDegrees = 0.5,
			CrosshairConfig = { Expansion = 15, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.6, -0.25, -0.12),
				CamKickMax = createVector(0.7, -0.1, 0.12),
				CamKickSpeed = 17
			},
			UseHoverHeightForHeadHeight = true
		},
		{
			WeaponName = "PAVE",
			NoTriggerClientTowerAttacked = true,
			UseAbilityName = Enums.TowerAbilities.CombatDronePAVE,
			BaseMultiplier = 1.5,
			MagSize = 2,
			ShotInterval = 1,
			ReloadTime = 12,
			ProjectileMissTravelDistance = 150,
			DefaultSpreadDegrees = 0.5,
			CrosshairConfig = { Expansion = 15, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.6, -0.25, -0.12),
				CamKickMax = createVector(0.7, -0.1, 0.12),
				CamKickSpeed = 17
			},
			UseHoverHeightForHeadHeight = true
		}
	},
	AbilityNames = { Enums.TowerAbilities.CombatDroneSpotterL2 },
	MovementConfig = { LevelStatsMovementSpeedMultiplier = 2, VerticalMovementSpeed = 8 }
}
return {
	LimitMap = { 2, 1, 1, 1 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 3000,
			Health = 800,
			CanTargetAir = true,
			HasDirectControl = true,
			DirectControlMagSize = 50,
			DirectControlReloadTime = 3,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 2,
			ReloadTime = 0.17,
			Range = 8,
			StealthDetection = false,
			MovementSpeed = 9,
			MovementDefaultMode = Enums.HelicopterModes.MoveToPlayer,
			IgnoreObstacles = true,
			AbilityNames = { Enums.TowerAbilities.HelicopterMoveToPlayer },
			TurretConfigs = { v },
			FirstPersonConfig = firstPersonConfig,
			Description = "BASE",
			Icon = "rbxassetid://119481097119931"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 1800,
				HealthIncrease = 100,
				DamageIncrease = 2,
				ReloadTimeDecrease = 0.02,
				AbilityNames = { Enums.TowerAbilities.HelicopterMoveToPlayer },
				TurretConfigs = { v },
				FirstPersonConfig = firstPersonConfig2,
				Description = "AR Platform",
				Icon = "rbxassetid://90765701035873",
				UpgradeIcon = "rbxassetid://112880134882310"
			},
			{
				Cost = 6500,
				HealthIncrease = 100,
				DamageIncrease = 10,
				AbilityNames = { Enums.TowerAbilities.HelicopterMoveToPlayer },
				TurretConfigs = { v },
				FirstPersonConfig = firstPersonConfig3,
				Description = "Heavy Ammo",
				Icon = "rbxassetid://106090819323495",
				UpgradeIcon = "rbxassetid://15266660711"
			},
			{
				Cost = 21000,
				DirectControlMagSizeIncrease = 125,
				HealthIncrease = 600,
				DamageIncrease = 12,
				ReloadTimeDecrease = 0.05,
				RangeIncrease = 5,
				MovementSpeedIncrease = 0,
				AbilityNames = { Enums.TowerAbilities.HelicopterMoveToPlayer, Enums.TowerAbilities.CombatDroneShieldL1 },
				TurretConfigs = { v2 },
				FirstPersonConfig = firstPersonConfig4,
				Description = "Gatling Gun",
				Icon = "rbxassetid://81436170858716",
				UpgradeIcon = "rbxassetid://134002888244059"
			},
			{
				Cost = 75000,
				DirectControlMagSizeIncrease = 50,
				HealthIncrease = 2800,
				DamageIncrease = 20,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToPlayer,
					Enums.TowerAbilities.CombatDroneShieldL2,
					Enums.TowerAbilities.CombatDroneRocketsP1L4
				},
				TurretConfigs = { v2, v3 },
				FirstPersonConfig = firstPersonConfig5,
				Description = "Rocket Pods",
				Icon = "rbxassetid://117923470109906",
				UpgradeIcon = "rbxassetid://137571886127001"
			},
			{
				Cost = 205000,
				HealthIncrease = 4000,
				DamageIncrease = 65,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				DamageType = Enums.DamageTypes.Laser,
				AbilityNames = {
					Enums.TowerAbilities.HelicopterMoveToPlayer,
					Enums.TowerAbilities.HelicopterMoveToFirst,
					Enums.TowerAbilities.CombatDroneShieldL3,
					Enums.TowerAbilities.CombatDroneRocketsP1L5,
					Enums.TowerAbilities.CombatDroneBomb
				},
				TurretConfigs = { v2, v3 },
				FirstPersonConfig = firstPersonConfig6,
				Description = "X22 Combat Drone",
				Icon = "rbxassetid://86926573186602",
				UpgradeIcon = "rbxassetid://100558313672663"
			}
		},
		Path2Data = {
			{
				Cost = 575,
				HealthIncrease = 100,
				GainStealthDetection = true,
				RangeIncrease = 8,
				AbilityNames = { Enums.TowerAbilities.HelicopterMoveToPlayer },
				TurretConfigs = { v },
				FirstPersonConfig = firstPersonConfig2,
				Description = "Upgraded Sensors",
				Icon = "rbxassetid://90765701035873",
				UpgradeIcon = "rbxassetid://71440279807981"
			},
			{
				Cost = 900,
				DirectControlMagSizeIncrease = 60,
				HealthIncrease = 100,
				DamageIncrease = 1,
				ReloadTimeDecrease = 0,
				MovementSpeedIncrease = 1,
				GainStunImmunity = true,
				AbilityNames = { Enums.TowerAbilities.HelicopterMoveToPlayer },
				TurretConfigs = { v },
				FirstPersonConfig = firstPersonConfig3,
				Description = "Additional Ammo",
				Icon = "rbxassetid://106090819323495",
				UpgradeIcon = "rbxassetid://98723049067328"
			},
			{
				Cost = 14000,
				DirectControlMagSizeOverride = 10,
				DirectControlReloadTimeOverride = 3,
				HealthIncrease = 1000,
				GainUntargetable = true,
				ProjectileName = Enums.Projectiles.CombatDroneMissile,
				DamageType = Enums.DamageTypes.Explosive,
				DamageIncrease = 139,
				ReloadTimeDecrease = -1.2,
				RangeIncrease = 300,
				SplashRadiusIncrease = 2.5,
				GainStealth = true,
				RegainStealthIfRevealed = true,
				TimeToRegainStealthOverride = 3,
				PylonMovementConfig = { Speed = 7, Radius = 25, Altitude = 18, PortAngle = 25 },
				FirstPersonConfig = {
					UIName = "CombatDroneP2",
					PlayerAnimationName = "CombatDroneTablet",
					ZoomOptions = { 80, 55, 30 },
					AttackConfigs = {
						{
							WeaponName = "MSL",
							NoTriggerClientTowerAttacked = true,
							BaseMultiplier = 1.5,
							ProjectileMissTravelDistance = 150,
							DefaultSpreadDegrees = 0.5,
							CrosshairConfig = { Expansion = 15, Speed = 20, Damper = 1 },
							RecoilConfig = {
								CamKickMin = createVector(0.6, -0.25, -0.12),
								CamKickMax = createVector(0.7, -0.1, 0.12),
								CamKickSpeed = 17
							},
							UseHoverHeightForHeadHeight = true
						}
					},
					MovementConfig = {
						LevelStatsMovementSpeedMultiplier = 2,
						VerticalMovementSpeed = 8
					}
				},
				OverrideUseMovingRangeCircle = false,
				Description = "Reaper Drone",
				Icon = "rbxassetid://125963506766000",
				UpgradeIcon = "rbxassetid://134386215448618"
			},
			{
				Cost = 82000,
				DirectControlMagSizeOverride = 10,
				DirectControlReloadTimeOverride = 2.2,
				HealthIncrease = 250,
				ProjectileName = Enums.Projectiles.CombatDroneMissile,
				DamageIncrease = 450,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				SplashRadiusIncrease = 1,
				AbilityNames = { Enums.TowerAbilities.CombatDroneSpotterL1 },
				PylonMovementConfig = { Speed = 7, Radius = 25, Altitude = 18, PortAngle = 25 },
				FirstPersonConfig = firstPersonConfig7,
				OverrideUseMovingRangeCircle = false,
				Description = "Enemy Highlight",
				Icon = "rbxassetid://82664356561024",
				UpgradeIcon = "rbxassetid://110653213099603"
			},
			{
				Cost = 130000,
				DirectControlMagSizeOverride = 20,
				DirectControlReloadTimeOverride = 2,
				HealthIncrease = 1000,
				ProjectileName = Enums.Projectiles.CombatDroneMissileMax,
				DamageIncrease = 20,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 0,
				SplashRadiusIncrease = 1,
				GainIgnoreResistance = true,
				AbilityNames = { Enums.TowerAbilities.CombatDronePAVE, Enums.TowerAbilities.CombatDroneSpotterL2 },
				PylonMovementConfig = { Speed = 7, Radius = 25, Altitude = 18, PortAngle = 25 },
				FirstPersonConfig = firstPersonConfig8,
				OverrideUseMovingRangeCircle = false,
				Description = "P.A.V.E Missiles",
				Icon = "rbxassetid://127051071758120",
				UpgradeIcon = "rbxassetid://100132520721163"
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
		ExplosionEffectName = Enums.VisualEffects.DroneDeath
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
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	BuffEffectScale = 2,
	UseMovingRangeCircle = true,
	NoBuffs = true,
	NoHeal = true,
	NoStealthShimmer = true,
	BASE_DAMAGE_MULTIPLIER = 1.5,
	HEADSHOT_DAMAGE_MULTIPLIER = 2.5,
	BOSS_HEADSHOT_DAMAGE_MULTIPLIER = 3.5,
	STRONG_BOSS_HEADSHOT_DAMAGE_MULTIPLIER = 5.5,
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 300,
			CostIncreasePerLevel = 150,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 500,
			CostIncreasePerLevel = 550,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 125,
			CostIncreasePerLevel = 75,
			Amount = 0.05
		},
		{
			Type = Enums.TowerUpgradeShopTypes.MovementSpeed,
			Cost = 150,
			CostIncreasePerLevel = 50,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 50,
			CostIncreasePerLevel = 20,
			Amount = 0.05
		}
	}
}