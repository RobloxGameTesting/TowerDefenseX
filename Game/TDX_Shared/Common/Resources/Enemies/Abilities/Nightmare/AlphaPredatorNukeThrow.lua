local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	CanTargetAir = false,
	ProjectileName = Enums.Projectiles.AlphaPredatorNuke,
	Range = 20,
	MinimumRange = 8,
	TargetMinimumValue = 150000,
	TargetMostExpensiveTower = true,
	HitVisualEffectVarianceXZ = 0.5,
	HitVisualEffectVarianceY = 0.25
}
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 30,
		HitDamageFalloffRanges = {
			{ Range = 0, Damage = 350000 },
			{ Range = 2.5, Damage = 25000 },
			{ Range = 5, Damage = 18000 },
			{ Range = 12, Damage = 6000 },
			{ Range = 18, Damage = 3000 },
			{ Range = 50, Damage = 1000 }
		}
	},
	StartingCooldown = 5,
	Cooldown = 19,
	Animated = true,
	AnimationName = "NukeThrow",
	Delay = 1,
	ExecutionTime = 4.3,
	FaceTarget = true,
	FaceTargetDelay = 0.5,
	ForceFaceOverideTime = 1.2,
	ForceFaceOverideTimeInitial = 1.2,
	PrerequisiteAbilityName = Enums.EnemyAbilities.AlphaPredatorRage,
	MaximumUses = 3,
	InstantPlayEffectParentInstanceNames = { "Root>SFX>NukeThrow" },
	EnemyToTowerRangedDataSequence = { v }
}