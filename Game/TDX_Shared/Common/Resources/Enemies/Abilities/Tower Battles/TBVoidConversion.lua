local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 30,
	Cooldown = 100,
	Animated = true,
	Delay = 2.65,
	ExecutionTime = 9.517,
	AnimationName = "TowerConversion",
	EffectParentInstanceNames = { "ConversionVFXPart" },
	EffectsStartDelay = 2.65,
	EffectsStopDelay = 8.6,
	EnemyToTowerRadiusEffectData = {
		TowerBuffNames = { Enums.TowerBuffs.VoidConversionBuff },
		HitPercentage = 0.1,
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
}