local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TurretTypes"))
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.AutoCannonImpact,
	TargetTorsoInsteadOfGround = true,
	VarianceXZ = 1,
	VarianceY = 0.5,
	Delay = 0.05
}
local v = {
	ModelName = "Turret1",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Gun",
			Animated = true,
			RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 35, MinRotationX = -20 }
		}
	}
}
local v2 = {
	ClientHitEffectData = clientHitEffectData,
	CanTargetAir = true,
	QueryType = "First",
	DisabledUntilWaveReached = 43,
	DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
	Damage = 2000,
	ReloadTime = 0.3,
	Range = 150,
	MinimumRange = 3,
	IsBurst = false
}
return {
	OverrideDisplayName = "GDA Turret",
	Radius = 4,
	HoverHeight = 0,
	NoAnimations = true,
	NoTweenOnSpawn = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	ClientsideAttackTargetTorsoPosition = true,
	HasHealth = true,
	Health = 12000,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.TBPart2Casual] = { Health = 12000 },
		[Enums.Difficulties.TBPart2Hard] = { Health = 6000 },
		[Enums.Difficulties.TBPart2Nightmare] = { Health = 3500 },
		[Enums.Difficulties.TBPart2Voidmare] = { Health = 275 }
	},
	DeathEffectInstanceNames = {},
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 2,
	FadeOutRemoveDelay = 1e999,
	HasAttack = true,
	AttackData = { v2 },
	TurretConfigs = { v },
	TurretNoTrackTarget = true
}