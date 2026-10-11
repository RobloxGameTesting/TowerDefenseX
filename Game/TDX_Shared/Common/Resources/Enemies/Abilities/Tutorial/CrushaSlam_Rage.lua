local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	DamageData = { Damage = 100 },
	TowerBuffNames = { Enums.TowerBuffs.CrushaSlamDebuff },
	Range = 12,
	HitAllTargetsInRange = true
}
return {
	StartingCooldown = 3,
	Cooldown = 37,
	Animated = true,
	Delay = 1.55,
	ExecutionTime = 4.467,
	BurstSize = 3,
	BurstInterval = 0.617,
	CustomBurstDelayMap = { 0.617, 0.65 },
	AnimationName = "Slam_Rage",
	PrerequisiteAbilityName = Enums.EnemyAbilities.CrushaRage,
	EffectParentInstanceNames = { "SmashEffects" },
	EnemyToTowerRangedDataSequence = { v }
}