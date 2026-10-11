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
	TowerBuffNames = { Enums.TowerBuffs.AlphaPredatorEMPDebuff }
}
return {
	StartingCooldown = 5,
	Cooldown = 45,
	Animated = true,
	AnimationName = "ChestHitEMP",
	Delay = 2.383,
	ExecutionTime = 4.3,
	ParallelAbilityNames = { Enums.EnemyAbilities.AlphaPredatorChestHitEMP_Parallel },
	EffectParentInstanceNames = { "ChestHitEMP" },
	InstantPlayEffectParentInstanceNames = { "Root>SFX>ChestHitEMP" },
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData
}