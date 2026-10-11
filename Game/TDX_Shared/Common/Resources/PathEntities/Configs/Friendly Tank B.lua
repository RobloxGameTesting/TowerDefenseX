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
			RotationOffset = CFrame.Angles(-1.5707963267948966, 3.141592653589793, 0),
			RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 20, MinRotationX = -7 }
		}
	}
}
local v2 = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.SmallBlast,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.35,
		VarianceY = 0.25
	},
	IsProjectile = false,
	IsSplash = true,
	SplashRadius = 1,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = false,
	Damage = 100,
	ReloadTime = 2,
	Range = 35,
	IsBurst = false
}
return {
	Health = 1000,
	Speed = 3,
	Radius = 3.3,
	CollisionRadius = 3.3,
	AntiStackingRadius = 3.3,
	HoverHeight = 1.21,
	AnimationTimeScale = 1,
	NoAnimations = false,
	IsVehicle = true,
	IsMechanical = true,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.HumveeDeath,
	DeathRemoveTextures = true,
	DeathColor = Color3.fromRGB(0, 0, 0),
	DeathMaterial = Enum.Material.CorrodedMetal,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	TurretConfigs = { v },
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = { v2 }
}