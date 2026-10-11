local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 80,
	Animated = true,
	Delay = 8.9,
	ExecutionTime = 11.3,
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
		TowerBuffNames = { Enums.TowerBuffs.EngineerEMPStunDebuff, Enums.TowerBuffs.EngineerEMPDisableAbilitiesDebuff },
		TowerInstantKillData = {
			{ InstantKillType = "EMP", TargetEMPVulnerableUnits = true, Count = 1e999 }
		}
	},
	EffectParentInstanceNames = { "EMPVFX1", "EMPVFX2", "RootPart>EMPSFX", "RootPart>EMPSFX2" }
}