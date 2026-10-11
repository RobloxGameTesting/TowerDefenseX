local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TableUtilities"))
local v = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Gun",
			InvertRotation = true,
			RotationConstraintConfig = {
				CanRotateX = true,
				MaxRotationX = 45,
				MinRotationX = -45,
				InvertX = true
			}
		}
	}
}
local v2 = {
	ModelName = "Turret2",
	AutoWeldToInstanceName = "Head",
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
local v3 = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.ExtraSmallBlast,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.35,
		VarianceY = 0.25
	},
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = false,
	Damage = 22,
	ReloadTime = 0.15,
	Range = 25,
	MinimumRange = 2
}
local v4 = {
	Description = "Rockets",
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.WarMachineRocket,
	IsSplash = true,
	SplashRadius = 2,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = false,
	Damage = 40,
	ReloadTime = 15,
	Range = 40,
	MinimumRange = 4,
	IsBurst = true,
	BurstSize = 8,
	BurstInterval = 0.8,
	AlwaysMaintainBurst = false,
	NoStopToAttack = true,
	NoAnimation = true
}
return {
	OverrideDisplayName = "Abrams Walker Level 0",
	Health = 3000,
	Speed = 2.9,
	Radius = 2,
	CollisionRadius = 2,
	AnimationTimeScale = 1,
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
	StopToAttack = true,
	MovementStartDelayLowerBound = 1,
	MovementStartDelayUpperBound = 1.2,
	ClientsideAttackTargetTorsoPosition = true,
	NoRestartAttackAnimationIfPlaying = true,
	AttackData = { v3, v4 },
	TurretConfigs = { v, v2 },
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true
}