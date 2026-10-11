local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local enemyToTowerRadiusEffectData = {
	MaximumRange = 30,
	TowerTypeIgnoreMap = {
		[Enums.Towers.Warship] = true,
		[Enums.Towers.GoldenWarship] = true,
		[Enums.Towers.Farm] = true,
		[Enums.Towers.ArmoredFactory] = true,
		[Enums.Towers.Barracks] = true,
		[Enums.Towers.EDJ] = true,
		[Enums.Towers.Medic] = true,
		[Enums.Towers.MineLayer] = true,
		[Enums.Towers.GoldenMineLayer] = true,
		[Enums.Towers.Zed] = true,
		[Enums.Towers.BehemothFactory] = true,
		[Enums.Towers.ShieldTower] = true
	},
	PathEntityTypeIgnoreMap = {
		[Enums.PathEntities.Zed0] = true,
		[Enums.PathEntities.Zed1] = true,
		[Enums.PathEntities.Zed2] = true,
		[Enums.PathEntities.Zed3] = true,
		[Enums.PathEntities.Zed4] = true,
		[Enums.PathEntities.Zed5] = true,
		[Enums.PathEntities.GoldenZed] = true
	}
}
return {
	StartingCooldown = 80,
	Cooldown = 120,
	Animated = true,
	AnimationName = "CrystalConversion",
	AutoHandleEffects = true,
	Delay = 0.7,
	ExecutionTime = 20.033,
	EffectsStartDelay = 0.7,
	EffectsStopDelay = 2.2,
	ParallelAbilityNames = {
		Enums.EnemyAbilities.UmbrixCrystalConversion_Wave1,
		Enums.EnemyAbilities.UmbrixCrystalConversion_Wave2,
		Enums.EnemyAbilities.UmbrixCrystalConversion_Wave3,
		Enums.EnemyAbilities.UmbrixCrystalConversion_Wave4,
		Enums.EnemyAbilities.UmbrixCrystalConversion_Wave5
	},
	EnemyToTowerRadiusEffectData = enemyToTowerRadiusEffectData
}