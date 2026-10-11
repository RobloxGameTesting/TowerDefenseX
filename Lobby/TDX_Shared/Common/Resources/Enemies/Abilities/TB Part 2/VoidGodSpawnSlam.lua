local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local centerPositionByMap = {
	[Enums.Maps.Genesis] = createVector(46.316, 147.89, 140.882)
}
local enemyToTowerRadiusEffectData = {
	RequeryBeforeExecution = true,
	MaximumRange = 60,
	MinimumTargets = 0,
	AffectTargetsWithNoAttack = true,
	CenterPosition = createVector(203.813, 39.769, 85.61),
	CenterPositionByMap = centerPositionByMap,
	DamageData = { Damage = 500 }
}
return {
	UseOnSpawnDelay = 7.85,
	StartingCooldown = 1e999,
	Cooldown = 1e999,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData
}