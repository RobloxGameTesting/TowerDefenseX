local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	CanTargetAir = false,
	ProjectileName = Enums.Projectiles.EasterEngineerWMRocket,
	Range = 50,
	MinimumRange = 10,
	TargetMostExpensiveTower = true,
	TryGetUniqueTargetForEachBurst = true,
	HitVisualEffectVarianceXZ = 0.5,
	HitVisualEffectVarianceY = 0.25
}
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 1,
		RemoveTowerInvulnerability = false,
		Damage = 12000
	},
	StartingCooldown = 7,
	Cooldown = 23,
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