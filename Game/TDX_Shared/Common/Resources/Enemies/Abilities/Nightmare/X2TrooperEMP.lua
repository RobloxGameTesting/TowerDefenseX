local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 40,
	Animated = true,
	Delay = 2.7,
	ExecutionTime = 5.383,
	AnimationName = "EMP",
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MaximumRange = 60,
		MinimumTargets = 3,
		AffectTargetsWithNoAttack = true,
		AffectMechanicalOnly = true,
		MinimumTargetPrerequisites = {
			ConsiderTargetsWithNoAttack = false,
			ConsiderMechanicalOnly = true
		},
		TowerBuffNames = {
			Enums.TowerBuffs.X2TrooperEMPStunDebuff,
			Enums.TowerBuffs.X2TrooperEMPDisableAbilitiesDebuff
		},
		TowerInstantKillData = {
			{ InstantKillType = "EMP", TargetEMPVulnerableUnits = true, Count = 1e999 }
		}
	},
	EffectParentInstanceNames = { "EMP" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>EMP" }
}