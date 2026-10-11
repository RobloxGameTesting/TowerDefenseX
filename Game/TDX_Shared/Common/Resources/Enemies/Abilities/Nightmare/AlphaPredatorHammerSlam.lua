local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	DamageData = { Damage = 1000 },
	TowerBuffNames = { Enums.TowerBuffs.AlphaPredatorHammerSlamDebuff },
	Range = 16,
	HitAllTargetsInRange = true
}
local enemyToTowerRadiusEffectData = {
	RequeryBeforeExecution = true,
	MinimumTargets = 0,
	AffectPathEntitiesOnly = true,
	MaximumRange = 16,
	DamageData = { Damage = 500 },
	TowerBuffNames = { Enums.TowerBuffs.AlphaPredatorHammerSlamDebuff }
}
return {
	StartingCooldown = 15,
	Cooldown = 30,
	Animated = true,
	Delay = 1.5,
	ExecutionTime = 4.8,
	AnimationName = "HammerSlam",
	FaceTarget = false,
	ParallelAbilityNames = { Enums.EnemyAbilities.AlphaPredatorHammerSlam_Gunshot },
	EnemyToTowerRangedDataSequence = { v },
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData,
	EffectParentInstanceNames = { "HammerSlam" },
	InstantPlayEffectParentInstanceNames = { "Root>SFX>HammerSlam" }
}