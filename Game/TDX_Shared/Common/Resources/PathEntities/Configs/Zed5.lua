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
			ModelName = "Gun",
			NoRotate = true,
			RotatingBarrelData = {
				{
					WeldPointerName = "RotatingBarrelWeld",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 0.5,
					TimeToStopRotation = 1,
					MaxRotationSpeedX = 5
				}
			}
		}
	}
}
local v2 = {
	Description = "Primary",
	IsProjectile = false,
	IsSplash = false,
	DamageType = Enums.DamageTypes.Laser,
	IgnoreResistance = false,
	Damage = 410,
	ReloadTime = 0.09,
	Range = 60,
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
	Damage = 700,
	ReloadTime = 6,
	Range = 60,
	MinimumRange = 3.3,
	IsBurst = true,
	BurstSize = 8,
	BurstInterval = 0.4,
	AlwaysMaintainBurst = false
}
return {
	OverrideDisplayName = "Z.E.D. Level 5",
	Health = 15000,
	Speed = 1.8,
	Radius = 2.2,
	CollisionRadius = 2.2,
	CollisionResistance = 0.1,
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
	StealthDetection = true,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = { v2, v3 }
}