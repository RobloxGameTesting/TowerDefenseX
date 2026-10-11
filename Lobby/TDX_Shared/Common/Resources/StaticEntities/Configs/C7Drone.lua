local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	TargetFirstWithAbility = true,
	CanTargetAir = true,
	IsProjectile = false,
	IsSplash = false,
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = true,
	Damage = 10,
	ReloadTime = 0.1,
	Range = 20,
	IsBurst = false
}
return {
	OverrideDisplayName = "C7 Drone",
	Radius = 0.1,
	HoverHeight = 4,
	HoverHeightVariance = 0.5,
	AnimationTimeScale = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	NoHead = true,
	NoTorso = true,
	SpawnAnimationTime = 1,
	Lifetime = 40,
	ExplodeAfterLifetime = true,
	HasAttack = true,
	StealthDetection = true,
	ClientsideAttackTargetTorsoPosition = true,
	StealthRevealData = { TimeToReveal = 1, InheritRange = true },
	AttackData = { v },
	TurretConfigs = {
		{
			ModelName = "Turret",
			RotationConstraintConfig = { CanRotateY = true },
			TurretGunConfigs = {
				{
					ModelName = "MainGun",
					RotationConstraintConfig = {
						CanRotateX = true,
						MaxRotationX = 0,
						MinRotationX = -45
					}
				}
			}
		}
	},
	ExplosionEffectNames = { Enums.VisualEffects.GrenadierGrenadeBlastSmall }
}