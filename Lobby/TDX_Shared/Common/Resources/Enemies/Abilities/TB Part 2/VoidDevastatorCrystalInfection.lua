local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	MinimumTargetsInRange = 3,
	CanTargetAir = false,
	TowerBuffNames = {
		Enums.TowerBuffs.VoidDevastatorCrystalInfectionDebuff,
		Enums.TowerBuffs.VoidDevastatorCrystalInfectionConversion
	},
	Range = 100,
	HitAllTargetsInRange = true
}
return {
	StartingCooldown = 0,
	Cooldown = 1e999,
	Animated = true,
	Delay = 2.833,
	ExecutionTime = 17.583000000000002,
	AnimationName = "CrystalInfection",
	AutoHandleEffects = true,
	TriggeredAtHealthPercentage = 0.6,
	MaximumUses = 1,
	ParallelAbilityNames = { Enums.EnemyAbilities.VoidDevastatorCrystalInfection_Summon },
	NextAbilityName = Enums.EnemyAbilities.VoidDevastatorAwakening,
	EnemyToTowerRangedDataSequence = { v },
	EnemyToTowerRadiusEffectData = {
		DoNotUseForTriggering = true,
		RequeryBeforeExecution = true,
		MaximumRange = 100,
		DamageData = { Damage = 1000 },
		AffectTargetsWithNoAttack = true
	}
}