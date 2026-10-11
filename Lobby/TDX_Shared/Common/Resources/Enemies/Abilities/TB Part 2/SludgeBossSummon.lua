local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	MaximumRange = 25,
	MinimumTargets = 0,
	TowerBuffNames = { Enums.TowerBuffs.SludgeBossDamageDebuff }
}
return {
	StartingCooldown = 30,
	StartingCooldownVariance = 5,
	Cooldown = 30,
	CooldownVariance = 1,
	Animated = true,
	AnimationName = "Summon",
	AutoHandleEffects = true,
	Delay = 0.55,
	ExecutionTime = 131 / 60,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.SludgeBoss,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 1,
			MaxSpawnOffsetStuds = 8,
			FavorSpawningInFrontOfParent = true,
			StaggerMaxDelay = 1
		},
		{
			EnemyType = Enums.Enemies.Sludge,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 4,
			MaxSpawnOffsetStuds = 8,
			StaggerMaxDelay = 1
		}
	},
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData
}