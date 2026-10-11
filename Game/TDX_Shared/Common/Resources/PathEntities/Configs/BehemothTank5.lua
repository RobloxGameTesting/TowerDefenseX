local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = { ModelName = "Gun", NoRotate = true }
local v2 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v }
}
local v3 = {
	ModelName = "SmallTurret",
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true, CanRotateX = false },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
local v4 = {
	ModelName = "MissileTurret",
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateX = false, CanRotateY = false, CanRotateZ = false },
	TurretGunConfigs = { v }
}
local v5 = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.BehemothTankExplosionLarge,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.35,
		VarianceY = 0.25
	},
	IsProjectile = false,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = true,
	Damage = 7000,
	IsSplash = true,
	SplashRadius = 3,
	ReloadTime = 3.2,
	Range = 50,
	MinimumRange = 5,
	IsBurst = true,
	BurstSize = 2,
	BurstInterval = 0.7,
	AlwaysMaintainBurst = false
}
local v6 = {
	Description = "Secondary",
	IsProjectile = false,
	IsSplash = false,
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = false,
	Damage = 350,
	ReloadTime = 0.15,
	Range = 40,
	MinimumRange = 5,
	IsBurst = false,
	NoAnimation = true
}
local v7 = {
	Description = "Rockets",
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.BehemothTankMissile,
	CanTargetAir = true,
	IsSplash = true,
	SplashRadius = 2.5,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = false,
	Damage = 700,
	ReloadTime = 4,
	Range = 50,
	MinimumRange = 5,
	IsBurst = true,
	BurstSize = 12,
	BurstInterval = 0.2,
	AlwaysMaintainBurst = false,
	NoAnimation = true
}
return {
	OverrideDisplayName = "Behemoth Level 5",
	Health = 62000,
	Speed = 2,
	Radius = 3.3,
	CollisionRadius = 3.3,
	CollisionResistance = 0.6,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	NoHead = true,
	NoTorso = true,
	IsVehicle = true,
	IsMechanical = true,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.BehemothTankDeath,
	DeathRemoveTextures = true,
	DeathColor = Color3.fromRGB(0, 0, 0),
	DeathMaterial = Enum.Material.CorrodedMetal,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	HasAttack = true,
	StopToAttack = false,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = { v5, v6, v7 },
	TurretConfigs = { v2, v3, v4 }
}