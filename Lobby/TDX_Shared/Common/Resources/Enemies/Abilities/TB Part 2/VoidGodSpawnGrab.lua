local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local centerPositionByMap = {
	[Enums.Maps.Genesis] = createVector(20.472, 145.637, 164.577)
}
local enemyToTowerRadiusEffectData = {
	RequeryBeforeExecution = true,
	MaximumRange = 20,
	MinimumTargets = 0,
	AffectTargetsWithNoAttack = true,
	CenterPosition = createVector(180.998, 39.769, 114.335),
	CenterPositionByMap = centerPositionByMap,
	DamageData = { Damage = 2500 }
}
return {
	UseOnSpawnDelay = 3.067,
	StartingCooldown = 1e999,
	Cooldown = 1e999,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData
}