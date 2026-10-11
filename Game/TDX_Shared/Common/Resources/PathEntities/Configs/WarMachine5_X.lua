local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local WarMachine0 = require(script.Parent:WaitForChild("WarMachine0"))
local v = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "GunLeft",
			InvertRotation = true,
			HasContinuousEffects = true,
			ContinuousEffectStopDelay = 1.1,
			RotatingBarrelData = {
				{
					WeldPointerName = "RotatingBarrelWeld1",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 1.1,
					TimeToStopRotation = 2.1,
					MaxRotationSpeedX = 30
				},
				{
					WeldPointerName = "RotatingBarrelWeld2",
					TimeToMaxRotationSpeed = 0.2,
					TimeToSpinAfterShot = 1,
					TimeToStopRotation = 1.9,
					MaxRotationSpeedX = 30
				}
			},
			RotationConstraintConfig = {
				CanRotateX = true,
				MaxRotationX = 45,
				MinRotationX = -45,
				InvertX = true
			},
			SoundGroupName = "Minigun",
			SoundGroupStopDelay = 0.3
		},
		{
			ModelName = "GunRight",
			InvertRotation = true,
			RotatingBarrelData = {
				{
					WeldPointerName = "RotatingBarrelWeld1",
					TimeToMaxRotationSpeed = 0.15,
					TimeToSpinAfterShot = 0.9,
					TimeToStopRotation = 2.2,
					MaxRotationSpeedX = 30
				},
				{
					WeldPointerName = "RotatingBarrelWeld2",
					TimeToMaxRotationSpeed = 0.3,
					TimeToSpinAfterShot = 1.2,
					TimeToStopRotation = 1.8,
					MaxRotationSpeedX = 30
				}
			},
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
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.ExtraSmallBlast,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.35,
		VarianceY = 0.25
	},
	DamageType = Enums.DamageTypes.Bullet,
	IgnoreResistance = false,
	Damage = 180,
	ReloadTime = 0.1,
	Range = 40,
	MinimumRange = 2
}
local v3 = {
	Description = "Rockets",
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.WarMachineRocket,
	IsSplash = true,
	SplashRadius = 2.5,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = false,
	Damage = 300,
	ReloadTime = 1.5,
	Range = 40,
	MinimumRange = 4,
	IsBurst = true,
	BurstSize = 8,
	BurstInterval = 0.3,
	AlwaysMaintainBurst = false,
	NoStopToAttack = true,
	NoAnimation = true
}
local copy = TableUtilities.DeepCopy(WarMachine0)
copy.OverrideDisplayName = "Abrams Walker Level 5"
copy.Health = 12500
copy.Speed = 2.9
copy.AttackData = { v2, v3 }
copy.TurretConfigs[1] = v
return copy