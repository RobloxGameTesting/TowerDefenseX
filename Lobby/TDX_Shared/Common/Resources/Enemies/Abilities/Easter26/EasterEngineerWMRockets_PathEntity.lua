local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	CanTargetAir = true,
	ProjectileName = Enums.Projectiles.EasterEngineerWMRocket,
	Range = 100,
	MinimumRange = 10,
	TargetPathEntitiesOnly = true,
	PathEntityInitialQueryReduceRange = 3,
	HitVisualEffectVarianceXZ = 0.5,
	HitVisualEffectVarianceY = 0.25
}
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 4,
		RemoveTowerInvulnerability = false,
		Damage = 2000,
		DamagePercentage = 0.5
	},
	StartingCooldown = 2,
	Cooldown = 9,
	Animated = true,
	Delay = 1.517,
	ExecutionTime = 3.133,
	BurstSize = 2,
	BurstInterval = 0.31600000000000006,
	PrerequisiteAbilityName = Enums.EnemyAbilities.EasterEngineerArm_WarMachine,
	AnimationName = "WMRockets",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = { v },
	EffectParentInstanceNames = {},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>WMRockets" }
}