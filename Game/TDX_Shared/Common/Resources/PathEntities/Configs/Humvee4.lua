local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	CanTargetAir = true,
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.HumveeMissile,
	IsSplash = true,
	SplashRadius = 2,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = false,
	Damage = 75,
	ReloadTime = 3,
	Range = 36,
	MinimumRange = 3,
	IsBurst = true,
	BurstSize = 6,
	BurstInterval = 0.25,
	AlwaysMaintainBurst = false
}
return {
	OverrideModelName = "HumveeMissileLauncher",
	OverrideDisplayName = "Humvee Level 4",
	Health = 570,
	Speed = 5,
	Radius = 2.2,
	CollisionRadius = 2.2,
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
						MaxRotationX = 45,
						MinRotationX = -20
					}
				}
			}
		}
	},
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = true,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = { v }
}