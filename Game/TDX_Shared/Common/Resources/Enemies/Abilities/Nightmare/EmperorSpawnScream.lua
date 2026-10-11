local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	MinimumTargetsInRange = 0,
	CanTargetAir = true,
	TowerBuffNames = { Enums.TowerBuffs.EmperorSpawnScreamDebuff },
	Range = 1000,
	HitAllTargetsInRange = true,
	ConsiderTargetsWithNoAttack = true
}
return {
	StartingCooldown = 3,
	Cooldown = 1e999,
	Animated = true,
	Delay = 5.4,
	ExecutionTime = 10.533,
	AnimationName = "SpawnScream",
	ParallelAbilityNames = { Enums.EnemyAbilities.EmperorSpawnScream_StaffSlam },
	EffectParentInstanceNames = { "SpawnScream" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>SpawnScream" },
	MaximumUses = 1,
	EnemyToTowerRangedDataSequence = { v }
}