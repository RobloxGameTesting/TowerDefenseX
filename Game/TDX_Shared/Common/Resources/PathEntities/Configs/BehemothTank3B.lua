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
		EffectName = Enums.VisualEffects.BehemothTankExplosionSmallB,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.35,
		VarianceY = 0.25
	},
	IsProjectile = false,
	DamageType = Enums.DamageTypes.Laser,
	IgnoreResistance = false,
	Damage = 2100,
	ReloadTime = 3.2,
	Range = 60,
	MinimumRange = 5,
	IsBurst = false
}
return {
	OverrideModelName = "BehemothTank4B",
	OverrideDisplayName = "Laser Behemoth Level 3",
	Health = 10000,
	Speed = 2.4,
	CollisionResistance = 0.2,
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
	DeathEffect = Enums.DeathEffects.BehemothTankDeathB,
	DeathRemoveTextures = true,
	DeathColor = Color3.fromRGB(0, 0, 0),
	DeathMaterial = Enum.Material.CorrodedMetal,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = true,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = { v2 },
	TurretConfigs = { v }
}