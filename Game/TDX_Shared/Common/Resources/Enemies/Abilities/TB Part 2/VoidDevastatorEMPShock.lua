local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	RequeryBeforeExecution = true,
	MaximumRange = 120,
	MinimumTargets = 3,
	AffectTargetsWithNoAttack = true,
	AffectMechanicalOrGoldenOnly = true,
	MinimumTargetPrerequisites = {
		ConsiderTargetsWithNoAttack = false,
		ConsiderMechanicalOrGoldenOnly = true
	},
	TowerBuffNames = { Enums.TowerBuffs.VoidDevastatorEMPDebuff },
	TowerInstantKillData = {
		{ InstantKillType = "EMP", TargetEMPVulnerableUnits = true, Count = 1e999 }
	}
}
return {
	StartingCooldown = 5,
	Cooldown = 45,
	Animated = true,
	AnimationName = "EMPShock",
	AutoHandleEffects = true,
	Delay = 4.05,
	ExecutionTime = 6.582999999999999,
	PrerequisiteAbilityName = Enums.EnemyAbilities.VoidDevastatorAwakening,
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData
}