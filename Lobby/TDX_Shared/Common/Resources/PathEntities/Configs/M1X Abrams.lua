local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.Blast125mm,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.35,
		VarianceY = 0.25
	},
	IsProjectile = false,
	IsSplash = true,
	SplashRadius = 2,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = true,
	Damage = 1200,
	ReloadTime = 3.2,
	Range = 38,
	MinimumRange = 4.5,
	IsBurst = false
}
local v2 = {
	Description = "50 Cal",
	IsProjectile = false,
	IsSplash = false,
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = false,
	Damage = 18,
	ReloadTime = 0.13,
	Range = 38,
	MinimumRange = 4.5,
	IsBurst = false
}
local v3 = {
	Description = "Gunner",
	IsProjectile = false,
	IsSplash = false,
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = false,
	Damage = 18,
	ReloadTime = 0.21,
	Range = 38,
	MinimumRange = 4.5,
	IsBurst = false
}
local v4 = {
	Description = "50 Cal 2",
	IsProjectile = false,
	IsSplash = false,
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = false,
	Damage = 18,
	ReloadTime = 0.17,
	Range = 38,
	MinimumRange = 4.5,
	IsBurst = false
}
return {
	OverrideDisplayName = "M1X Abrams",
	Health = 6250,
	Speed = 3.5,
	Radius = 3.6,
	CollisionResistance = 0.25,
	CollisionRadius = 3.6,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	NoAnimations = true,
	IsVehicle = true,
	IsMechanical = true,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.M1AbramsDeath,
	DeathRemoveTextures = true,
	DeathColor = Color3.fromRGB(0, 0, 0),
	DeathMaterial = Enum.Material.CorrodedMetal,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	TurretConfigs = {
		{
			ModelName = "Turret",
			RotationConstraintConfig = { CanRotateY = true },
			TurretGunConfigs = {
				{
					ModelName = "MainGun",
					RotationConstraintConfig = {
						CanRotateX = true,
						MaxRotationX = 20,
						MinRotationX = -8
					}
				}
			}
		},
		{
			ModelName = "Turret2",
			RotationConstraintConfig = { CanRotateY = true },
			TurretGunConfigs = {
				{
					ModelName = "MainGun",
					RotationConstraintConfig = {
						CanRotateX = true,
						MaxRotationX = 20,
						MinRotationX = -8
					}
				}
			}
		},
		{
			ModelName = "Turret3",
			RotationConstraintConfig = { CanRotateY = true },
			TurretGunConfigs = {
				{
					ModelName = "MainGun",
					RotationConstraintConfig = {
						CanRotateX = true,
						MaxRotationX = 20,
						MinRotationX = -8
					}
				}
			}
		},
		{
			ModelName = "Turret4",
			RotationConstraintConfig = { CanRotateY = true },
			TurretGunConfigs = {
				{
					ModelName = "MainGun",
					RotationConstraintConfig = {
						CanRotateX = true,
						MaxRotationX = 20,
						MinRotationX = -8
					}
				}
			}
		}
	},
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = true,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = { v, v2, v3, v4 }
}