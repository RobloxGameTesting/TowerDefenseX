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
					MaxRotationSpeedX = 4
				}
			}
		}
	}
}
local v2 = {
	Description = "Minigun",
	IsProjectile = false,
	IsSplash = false,
	IsBurst = false,
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = true,
	Damage = 700,
	ReloadTime = 0.08,
	Range = 150,
	MinimumRange = 3
}
local v3 = {
	Description = "Missile",
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.ZedMissile,
	NoAnimation = true,
	IsSplash = true,
	SplashRadius = 6,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = true,
	Damage = 2500,
	ReloadTime = 5,
	Range = 145,
	MinimumRange = 3.3,
	IsBurst = true,
	BurstSize = 12,
	BurstInterval = 0.2,
	AlwaysMaintainBurst = false
}
return {
	OverrideDisplayName = "Mega Z.E.D.",
	Health = 67000,
	Speed = 2.2,
	Radius = 2.2,
	CollisionRadius = 2.2,
	CollisionResistance = 0.95,
	HoverHeight = 2.11,
	AnimationTimeScale = 1,
	NoHead = true,
	NoTorso = true,
	IsVehicle = true,
	IsMechanical = true,
	NoPathOffset = true,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
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
	StunImmunity = true,
	NoRestartAttackAnimationIfPlaying = true,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = { v2, v3 }
}