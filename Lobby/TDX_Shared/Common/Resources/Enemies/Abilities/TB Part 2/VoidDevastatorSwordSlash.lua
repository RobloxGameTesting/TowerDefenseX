local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TowerBuffNames = { Enums.TowerBuffs.VoidDevastatorSwordSwingStun },
	PathEntityDamageData = { InstantKill = true },
	Range = 25,
	ArcSpreadAngle = 180
}
return {
	StartingCooldown = 3,
	Cooldown = 25,
	Animated = true,
	Delay = 1.517,
	ExecutionTime = 2.883,
	AutoHandleEffects = true,
	PrerequisiteAbilityName = Enums.EnemyAbilities.VoidDevastatorAwakening,
	AnimationName = "SwordSlash",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = { v }
}