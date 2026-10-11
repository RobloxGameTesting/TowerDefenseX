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
			ModelName = "MainGun",
			RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 25, MinRotationX = -12 }
		}
	}
}
local v2 = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.ExtraSmallBlast,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.35,
		VarianceY = 0.25
	},
	IsProjectile = false,
	IsSplash = true,
	SplashRadius = 1.25,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = false,
	Damage = 100,
	ReloadTime = 0.25,
	Range = 20,
	MinimumRange = 3.3,
	IsBurst = false
}
local v3 = {
	Description = "Missile",
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.M2BradleyMissile,
	IsSplash = true,
	SplashRadius = 3,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = true,
	Damage = 700,
	ReloadTime = 10,
	Range = 40,
	MinimumRange = 3.3,
	IsBurst = true,
	BurstSize = 2,
	BurstInterval = 1,
	AlwaysMaintainBurst = false
}
return {
	OverrideDisplayName = "M2 Bradley",
	Health = 1750,
	Speed = 4.5,
	Radius = 2.6,
	CollisionRadius = 2.6,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	NoAnimations = true,
	IsVehicle = true,
	IsMechanical = true,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.M2BradleyDeath,
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
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = { v2, v3 }
}