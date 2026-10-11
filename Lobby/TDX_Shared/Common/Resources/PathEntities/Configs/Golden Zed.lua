local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Turret",
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
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = true,
	Damage = 800,
	ReloadTime = 0.08,
	Range = 35,
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
	Damage = 4000,
	ReloadTime = 3,
	Range = 35,
	MinimumRange = 3.3,
	IsBurst = true,
	BurstSize = 8,
	BurstInterval = 0.35,
	AlwaysMaintainBurst = false
}
return {
	OverrideDisplayName = "Golden Z.E.D.",
	Health = 100000,
	Speed = 3,
	Radius = 2.2,
	CollisionRadius = 2.2,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	NoAnimations = true,
	IsVehicle = true,
	IsMechanical = true,
	IsGolden = true,
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
	TurretConfigs = { v, v },
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = true,
	StunImmunity = true,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = { v2, v3 }
}