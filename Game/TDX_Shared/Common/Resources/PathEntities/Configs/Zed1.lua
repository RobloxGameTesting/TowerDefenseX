local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	IsProjectile = false,
	IsSplash = false,
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = false,
	Damage = 12,
	ReloadTime = 0.13,
	Range = 35,
	MinimumRange = 3,
	IsBurst = false
}
return {
	OverrideDisplayName = "Z.E.D. Level 1",
	Health = 820,
	Speed = 2.7,
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
	DeathStopCurrentAnimation = true,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	TurretConfigs = {
		{
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
							MaxRotationSpeedX = 10
						}
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