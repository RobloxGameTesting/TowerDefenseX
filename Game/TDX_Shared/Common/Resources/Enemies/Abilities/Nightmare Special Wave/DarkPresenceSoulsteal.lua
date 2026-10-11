local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 40,
	Cooldown = 50,
	Animated = true,
	AnimationName = "Soulsteal",
	Delay = 11 / 6,
	ExecutionTime = 4,
	EffectParentInstanceNames = { "Conversion>Main>VFX", "Conversion>Main>SFX" },
	EffectsStartDelay = 0,
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 35,
		MinimumTargets = 1,
		MaximumTargets = 5,
		TowerBuffNames = { Enums.TowerBuffs.DarkPresenceConversion, Enums.TowerBuffs.DarkPresenceStun },
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
			[Enums.PathEntities.WarMachine5_X] = true,
			[Enums.PathEntities.WarMachineX_5] = true,
			[Enums.PathEntities.Zed5] = true,
			[Enums.PathEntities.GoldenZed] = true
		}
	},
	SelfEnemyBuffNames = { Enums.EnemyBuffs.DarkPresenceHealBuff },
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Conversion>Main>Beam",
				MakeNewBeam = true,
				BeamDuration = 1.0000000000000002,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}