local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TowerBuffNames = { Enums.TowerBuffs.BunnyZillaBurrowDamageTowers },
	Range = 14,
	HitAllTargetsInRange = true
}
local enemyToTowerRadiusEffectData = {
	RequeryBeforeExecution = true,
	MinimumTargets = 0,
	AffectPathEntitiesOnly = true,
	MaximumRange = 14,
	TowerBuffNames = { Enums.TowerBuffs.BunnyZillaBurrowDamagePathEntities }
}
return {
	StartingCooldown = 10,
	Cooldown = 30,
	Animated = true,
	Delay = 3,
	ExecutionTime = 7,
	AnimationName = "Burrow",
	MaxStudsRemainingCanUse = 90,
	ContinueMovingWhileUsing = true,
	ForcePlayAnimationOnClientside = true,
	NextAbilityName = Enums.EnemyAbilities.BunnyZillaEmerge,
	ParallelAbilityNames = { Enums.EnemyAbilities.BunnyZillaBurrowInvulnerability },
	EnemyToTowerRangedDataSequence = { v },
	ContinuouslyExecuteRangedDataSequence = true,
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData,
	InstantPlayEffectParentInstanceNames = { "HumanoidRootPart>SFX>Burrow" },
	EffectParentInstanceNames = { "BurrowFX" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 3,
	MovementSpeedData = {
		StartTime = 0,
		TimingData = {
			{ Time = 0, MovementSpeed = 0 },
			{ Time = 3, MovementSpeed = 12 },
			{ Time = 7, ResetToDefault = true }
		}
	}
}