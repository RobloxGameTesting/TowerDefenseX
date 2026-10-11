local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	DoNotUseForTriggering = true,
	MaximumRange = 35,
	TowerBuffNames = { Enums.TowerBuffs.VoidJuggernaut2OrbFlashStun }
}
local enemyToEnemyRadiusEffectData = {
	AffectEnemyTypeMap = {
		[Enums.Enemies.VoidJuggernaut1] = true,
		[Enums.Enemies.VoidJuggernaut2] = true
	},
	HealData = { HealAmount = 100000 }
}
return {
	StartingCooldown = 15,
	Cooldown = 45,
	Animated = true,
	Delay = 61 / 30,
	ExecutionTime = 8 / 3,
	AnimationName = "OrbFlash",
	AutoHandleEffects = true,
	AffectedEntityEffectData = {
		EffectName = Enums.VisualEffects.VoidJuggernaut2OrbFlashHit,
		EffectPositionOnHead = true
	},
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData,
	EnemyToEnemyRadiusEffectData = enemyToEnemyRadiusEffectData
}