local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 30,
	Animated = true,
	Delay = 8.9,
	ExecutionTime = 11.3,
	AnimationName = "EMP",
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MaximumRange = 70,
		MinimumTargets = 3,
		AffectTargetsWithNoAttack = true,
		MinimumTargetPrerequisites = { ConsiderTargetsWithNoAttack = false },
		TowerBuffNames = {
			Enums.TowerBuffs.EngineerNightmareEMPStunDebuff,
			Enums.TowerBuffs.EngineerNightmareEMPDisableAbilitiesDebuff
		},
		TowerInstantKillData = {
			{ InstantKillType = "EMP", TargetEMPVulnerableUnits = true, Count = 1e999 }
		}
	},
	EffectParentInstanceNames = { "EMPVFX1", "EMPVFX2", "RootPart>EMPSFX", "RootPart>EMPSFX2" }
}