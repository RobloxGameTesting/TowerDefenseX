local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.TOWRocket,
	IsSplash = true,
	SplashRadius = 2.5,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = false,
	Damage = 65,
	ReloadTime = 4,
	Range = 42,
	MinimumRange = 3,
	IsBurst = false
}
return {
	OverrideModelName = "HumveeTOW",
	OverrideDisplayName = "Humvee Level 2",
	Health = 245,
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
						MaxRotationX = 30,
						MinRotationX = -20
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