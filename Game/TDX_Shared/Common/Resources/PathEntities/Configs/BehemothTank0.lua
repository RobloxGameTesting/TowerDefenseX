local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
local v2 = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.BehemothTankExplosionSmall,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.35,
		VarianceY = 0.25
	},
	IsProjectile = false,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = false,
	Damage = 300,
	ReloadTime = 3.2,
	IsSplash = true,
	SplashRadius = 3,
	Range = 25,
	MinimumRange = 5,
	IsBurst = false
}
return {
	OverrideModelName = "BehemothTank1",
	OverrideDisplayName = "Behemoth Level 0",
	Health = 3800,
	CollisionResistance = 0.1,
	Speed = 4,
	Radius = 3.3,
	CollisionRadius = 3.3,
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
	AttackData = { v2 },
	TurretConfigs = { v }
}