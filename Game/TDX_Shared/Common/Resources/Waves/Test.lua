local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local _ = {
	LoadoutSelectionConfigs = {
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.Assault,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Assault,
			IconId = "rbxassetid://77242869433652",
			VIPOnly = false,
			Towers = {
				Enums.Towers.John,
				Enums.Towers.Grenadier,
				Enums.Towers.Juggernaut,
				Enums.Towers.Operator,
				Enums.Towers.MissileTrooper,
				Enums.Towers.Sniper
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.Support,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Support,
			IconId = "rbxassetid://112662075132649",
			VIPOnly = false,
			Towers = {
				Enums.Towers.EDJ,
				Enums.Towers.Barracks,
				Enums.Towers.ArmoredFactory,
				Enums.Towers.Commander,
				Enums.Towers.Ghost,
				Enums.Towers.Medic
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.HeavyWeapons,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.HeavyWeapons,
			IconId = "rbxassetid://107079411064021",
			VIPOnly = false,
			Towers = {
				Enums.Towers.Artillery,
				Enums.Towers.Juggernaut,
				Enums.Towers.FlameTrooper,
				Enums.Towers.John,
				Enums.Towers.Railgunner,
				Enums.Towers.Toxicnator
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.SpecialForces,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.SpecialForces,
			IconId = "rbxassetid://76800397073968",
			VIPOnly = true,
			Towers = {
				Enums.Towers.FlameTrooper,
				Enums.Towers.GoldenRanger,
				Enums.Towers.XWMTurret,
				Enums.Towers.Mobster,
				Enums.Towers.Medic,
				Enums.Towers.EDJ
			}
		}
	}
}
return {
	DisplayName = "Test",
	StartingCash = 2000000,
	CashPerDamageData = {
		{ CashPerDamage = 1.5, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.2, CashPerDamageShared = 1 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.5 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.25 }
	},
	CumulativeLevelToExtraCashPerDamageDataMap = {
		{ MaxLevel = 10, CashPerDamage = 0.6, CashPerDamageShared = 0 },
		{ MaxLevel = 20, CashPerDamage = 0.5, CashPerDamageShared = 0 },
		{ MaxLevel = 30, CashPerDamage = 0.4, CashPerDamageShared = 0 },
		{ MaxLevel = 40, CashPerDamage = 0.3, CashPerDamageShared = 0 },
		{ MaxLevel = 60, CashPerDamage = 0.2, CashPerDamageShared = 0 },
		{ MaxLevel = 80, CashPerDamage = 0.1, CashPerDamageShared = 0 }
	},
	UpgradeShopEnabled = true,
	PlayerCountToUpgradeShopStartingCredits = { 30000, 15000, 10000, 7500 },
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 100, TokensReward = 0, CookiesReward = 10 },
		{ WaveNumber = 2, GoldReward = 200, TokensReward = 0, CookiesReward = 20 },
		{ WaveNumber = 3, GoldReward = 300, TokensReward = 5, CookiesReward = 30 },
		{ WaveNumber = 4, GoldReward = 250, TokensReward = 10, CookiesReward = 30 },
		{ WaveNumber = 5, GoldReward = 550, TokensReward = 15, CookiesReward = 40 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			CostGold = 100,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_05,
			GainCash = 500,
			GainHP = 15000
		},
		{
			WaveNumber = 2,
			CostGold = 200,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 1000,
			GainHP = 200000
		},
		{
			WaveNumber = 8,
			CostGold = 300,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 1500,
			GainHP = 5
		},
		{
			WaveNumber = 12,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 200,
			GainHP = 5
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			WaveNumber = 1,
			RollCount = 2,
			ChanceTable = { [Enums.PowerUps.AC130Support] = 1, [Enums.PowerUps.A10Strike] = 1 }
		},
		{
			WaveNumber = 2,
			RollCount = 4,
			ChanceTable = { [Enums.PowerUps.AC130Support] = 1, [Enums.PowerUps.A10Strike] = 1 }
		},
		{
			WaveNumber = 3,
			RollCount = 2,
			ChanceTable = { [Enums.PowerUps.AC130Support] = 1, [Enums.PowerUps.A10Strike] = 1 }
		},
		{
			OnWin = true,
			RollCount = 2,
			ChanceTable = { [Enums.PowerUps.AC130Support] = 1, [Enums.PowerUps.A10Strike] = 1 }
		}
	},
	SkinRewardIntervalMap = {
		{
			WaveNumber = 1,
			SkinName = Enums.Towers.MineLayer .. "_Christmas"
		},
		{
			WaveNumber = 2,
			SkinName = Enums.Towers.Farm .. "_Christmas"
		},
		{
			WaveNumber = 3,
			SkinName = Enums.Towers.Operator .. "_Christmas"
		},
		{
			WaveNumber = 4,
			SkinName = Enums.Towers.Operator .. "_Christmas"
		}
	},
	DefaultXPPerWavePassed = 100,
	StartingLives = 5,
	SetUpTime = 5,
	TowerCostMultiplierMap = { [Enums.Towers.CombatDrone] = 2.5 },
	PreloadEnemyNames = {},
	Waves = {
		{
			CashBonus = 0,
			PlayerCountToUpgradeShopCreditPool = { 1000, 550, 350, 275 },
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Atrazine, Count = 1, Interval = 3 }
			}
		},
		{
			CashBonus = 0,
			PlayerCountToUpgradeShopCreditPool = { 1000, 550, 350, 275 },
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Atrazine, Count = 1, Interval = 0.15 }
			}
		}
	}
}