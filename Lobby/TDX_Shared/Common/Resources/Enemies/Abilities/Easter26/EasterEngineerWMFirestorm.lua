local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	RequeryBeforeExecution = true,
	AffectTargetsWithNoAttack = true,
	MinimumTargets = 2,
	MaximumRange = 28,
	TowerBuffNames = { Enums.TowerBuffs.EasterEngineerFirestormFirerateDebuff },
	DamageData = { Damage = 7 }
}
return {
	StartingCooldown = 5,
	Cooldown = 40,
	Animated = true,
	AnimationName = "WMFirestorm",
	Delay = 1.75,
	ExecutionTime = 11.5,
	BurstSize = 80,
	BurstInterval = 0.1,
	PrerequisiteAbilityName = Enums.EnemyAbilities.EasterEngineerArm_WarMachine,
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData,
	EffectParentInstanceNames = { "WMFirestorm", "WMFlamethrower" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>WMFirestorm" }
}