local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	DoNotTryToUse = true,
	Delay = 16,
	ExecutionTime = 0,
	EffectsStartDelay = 16,
	EffectsStopDelay = 17.5,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 30,
		MaximumTargets = 2,
		TowerBuffNames = { Enums.TowerBuffs.UmbrixCrystalConversionDebuff },
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
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "CrystalTop>ConversionRay",
				MakeNewBeam = true,
				TargetHead = true,
				BeamDuration = 1
			}
		}
	}
}