local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Turret",
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "LeftGun",
			NoRotate = true,
			RotatingBarrelData = {
				{
					WeldPointerName = "RotatingBarrelWeld",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 0.5,
					TimeToStopRotation = 1,
					MaxRotationSpeedX = 10
				}
			}
		},
		{
			ModelName = "RightGun",
			NoRotate = true,
			RotatingBarrelData = {
				{
					WeldPointerName = "RotatingBarrelWeld",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 0.5,
					TimeToStopRotation = 1,
					MaxRotationSpeedX = 10
				}
			}
		}
	}
}
local v2 = {
	Description = "Primary",
	IsProjectile = false,
	IsSplash = false,
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = false,
	Damage = 30,
	ReloadTime = 0.09,
	Range = 40,
	MinimumRange = 3,
	IsBurst = false
}
local v3 = {
	Description = "Missile",
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.ZedMissile,
	IsSplash = true,
	SplashRadius = 3,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = true,
	Damage = 125,
	ReloadTime = 3,
	Range = 40,
	MinimumRange = 3.3,
	IsBurst = true,
	BurstSize = 2,
	BurstInterval = 0.5,
	AlwaysMaintainBurst = false
}
return {
	OverrideDisplayName = "Z.E.D. Level 3",
	Health = 2200,
	Speed = 2.5,
	Radius = 2.2,
	CollisionRadius = 2.2,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	NoAnimations = true,
	IsVehicle = true,
	IsMechanical = true,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.HumveeDeath,
	DeathRemoveTextures = true,
	DeathColor = Color3.fromRGB(0, 0, 0),
	DeathMaterial = Enum.Material.CorrodedMetal,
	DeathStopCurrentAnimation = true,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	TurretConfigs = { v, v },
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = false,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = { v2, v3 }
}