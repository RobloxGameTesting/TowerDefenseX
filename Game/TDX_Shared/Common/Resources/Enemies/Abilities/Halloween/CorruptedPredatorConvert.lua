local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 13,
	Cooldown = 40,
	Animated = true,
	Delay = 0.8,
	ExecutionTime = 2.133,
	AnimationName = "Convert",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.CorruptedPredatorConversion },
			Range = 50,
			MinimumRange = 5,
			IgnoreConvertedTargets = true,
			TargetRandomTower = true,
			BeamEffectHandlingData = {
				{ BeamParentInstanceName = "LaserEyeBeamPart", BeamDuration = 0.883 }
			},
			TowerTypeIgnoreMap = {
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
			}
		}
	},
	EffectParentInstanceNames = { "Root>ConvertBeamSFX" }
}