local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	DamageData = { Damage = 1000 },
	TowerBuffNames = { Enums.TowerBuffs.BunnyZillaEmergeStun },
	Range = 12,
	HitAllTargetsInRange = true
}
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 61 / 30,
	ExecutionTime = 3.5,
	AnimationName = "Emerge",
	DoNotTryToUse = true,
	PrerequisiteAbilityName = Enums.EnemyAbilities.BunnyZillaBurrow,
	ParallelAbilityNames = { Enums.EnemyAbilities.BunnyZillaEmergeInvulnerability },
	EnemyToTowerRangedDataSequence = { v },
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MinimumTargets = 0,
		AffectPathEntitiesOnly = true,
		MaximumRange = 12,
		DamageData = { InstantKill = true }
	},
	InstantPlayEffectParentInstanceNames = { "HumanoidRootPart>SFX>Emerge" },
	EffectParentInstanceNames = { "GroundFX" }
}