local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.ExtraSmallBlast,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.35,
		VarianceY = 0.25
	},
	IsProjectile = false,
	IsSplash = true,
	SplashRadius = 1,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = false,
	Damage = 15,
	ReloadTime = 0.25,
	Range = 25,
	MinimumRange = 3,
	IsBurst = false
}
return {
	OverrideDisplayName = "MRAP",
	Health = 1000,
	Speed = 4,
	Radius = 2.4,
	CollisionRadius = 2.4,
	CollisionResistance = 0.1,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	NoAnimations = true,
	IsVehicle = true,
	IsMechanical = true,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.MRAPDeath,
	DeathRemoveTextures = true,
	DeathColor = Color3.fromRGB(0, 0, 0),
	DeathMaterial = Enum.Material.CorrodedMetal,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	TurretConfigs = {
		{
			ModelName = "Turret",
			RotationConstraintConfig = { CanRotateY = true },
			TurretGunConfigs = {
				{
					ModelName = "MainGun",
					RotationConstraintConfig = {
						CanRotateX = true,
						MaxRotationX = 20,
						MinRotationX = -12
					}
				}
			}
		}
	},
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = false,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = { v }
}