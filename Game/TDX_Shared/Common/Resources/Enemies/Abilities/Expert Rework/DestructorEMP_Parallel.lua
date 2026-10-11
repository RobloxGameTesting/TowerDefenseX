local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 3.1,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MaximumRange = 14,
		AffectTargetsWithNoAttack = true,
		AffectMechanicalOrGoldenOnly = true,
		TowerInstantKillData = {
			{ InstantKillType = "EMP", TargetEMPVulnerableUnits = true, Count = 1e999 }
		}
	}
}