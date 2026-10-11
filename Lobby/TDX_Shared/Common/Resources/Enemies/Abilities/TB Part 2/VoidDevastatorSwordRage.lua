local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	DamageData = {
		Damage = 450000 / 255
	},
	TowerBuffNames = { Enums.TowerBuffs.VoidDevastatorSwordRageStun },
	Range = 28,
	HitAllTargetsInRange = true,
	CenterForwardOffset = 20
}
return {
	StartingCooldown = 3,
	Cooldown = 45,
	Animated = true,
	Delay = 2.183,
	ExecutionTime = 7.7669999999999995,
	BurstSize = 17,
	BurstInterval = 0.1,
	CustomBurstDelayMap = {
		0.06700000000000017,
		0.617,
		0.2999999999999998,
		0.3160000000000003,
		0.25,
		0.19999999999999973,
		0.26700000000000035,
		0.18299999999999983,
		0.23399999999999999,
		0.25,
		0.23299999999999965,
		0.21700000000000053,
		0.2160000000000002,
		0.25,
		0.23399999999999999,
		0.2999999999999998,
		0.3330000000000002
	},
	AutoHandleEffects = true,
	PrerequisiteAbilityName = Enums.EnemyAbilities.VoidDevastatorAwakening,
	AnimationName = "SwordRage",
	FaceTarget = true,
	FaceTargetOnInitialTargetOnly = true,
	EnemyToTowerRangedDataSequence = { v }
}