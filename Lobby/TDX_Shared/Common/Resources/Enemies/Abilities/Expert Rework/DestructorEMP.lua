local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	RequeryBeforeExecution = true,
	MaximumRange = 45,
	MinimumTargets = 3,
	AffectTargetsWithNoAttack = true,
	AffectMechanicalOrGoldenOnly = true,
	MinimumTargetPrerequisites = {
		ConsiderTargetsWithNoAttack = false,
		ConsiderMechanicalOrGoldenOnly = true
	},
	TowerBuffNames = { Enums.TowerBuffs.DestructorEMPDebuff }
}
return {
	StartingCooldown = 5,
	Cooldown = 45,
	Animated = true,
	AnimationName = "EMP",
	SecondaryAnimationForKeyframeEventsName = "EMPDamaged",
	Delay = 3.1,
	ExecutionTime = 5.5329999999999995,
	ParallelAbilityNames = { Enums.EnemyAbilities.DestructorEMP_Parallel },
	EffectParentInstanceNames = { "EMP" },
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData
}