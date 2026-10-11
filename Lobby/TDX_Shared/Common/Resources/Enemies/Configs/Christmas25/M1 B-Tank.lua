local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "TurretModel",
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
return {
	Health = 70000,
	SuperStunResistance = true,
	Shield = 80000,
	Speed = 2.4,
	BodyHeat = 50000,
	BodyHeatRegenerationRate = 3000,
	Radius = 1,
	NoHead = true,
	NoTorso = true,
	IsMechanical = true,
	HasAttack = true,
	StopToAttack = false,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = {
		{
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
			Damage = 2000,
			ReloadTime = 3.2,
			IsSplash = true,
			SplashRadius = 4,
			Range = 27,
			MinimumRange = 6,
			IsBurst = false
		}
	},
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.M1AbramsDeath,
	DeathRemoveTextures = true,
	DeathColor = Color3.fromRGB(0, 0, 0),
	DeathMaterial = Enum.Material.CorrodedMetal,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	TurretConfigs = { v },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 }
	}
}