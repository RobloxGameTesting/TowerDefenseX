local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
local waves = {}
local Endless = {
	DisplayName = "Endless",
	StartingCash = 2100,
	CashPerDamageData = {
		{ CashPerDamage = 1.35, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.05, CashPerDamageShared = 0.5 },
		{ CashPerDamage = 0.8, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 0.7, CashPerDamageShared = 0.25 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 0 },
		{ WaveNumber = 3, GoldReward = 25, TokensReward = 2 },
		{ WaveNumber = 5, GoldReward = 20, TokensReward = 2 },
		{ WaveNumber = 8, GoldReward = 30, TokensReward = 4 },
		{ WaveNumber = 16, GoldReward = 125, TokensReward = 15 },
		{ WaveNumber = 21, GoldReward = 165, TokensReward = 30 },
		{ WaveNumber = 25, GoldReward = 325, TokensReward = 45 },
		{ WaveNumber = 29, GoldReward = 375, TokensReward = 55 },
		{ WaveNumber = 30, GoldReward = 625, TokensReward = 65 },
		{ WaveNumber = 34, GoldReward = 650, TokensReward = 85 },
		{ WaveNumber = 35, GoldReward = 700, TokensReward = 90 },
		{ WaveNumber = 39, GoldReward = 825, TokensReward = 95 },
		{ WaveNumber = 40, GoldReward = 1500, TokensReward = 125 },
		{ WaveNumber = 50, GoldReward = 2500, TokensReward = 150 },
		{ WaveNumber = 55, GoldReward = 2675, TokensReward = 165 },
		{ WaveNumber = 60, GoldReward = 3500, TokensReward = 180 },
		{ WaveNumber = 65, GoldReward = 3800, TokensReward = 200 },
		{ WaveNumber = 70, GoldReward = 4000, TokensReward = 250 },
		{ WaveNumber = 80, GoldReward = 6575, TokensReward = 300 },
		{ WaveNumber = 90, GoldReward = 6850, TokensReward = 400 },
		{ WaveNumber = 100, GoldReward = 7500, TokensReward = 555 },
		{ WaveNumber = 130, GoldReward = 10000, TokensReward = 777 },
		{ WaveNumber = 150, GoldReward = 11000, TokensReward = 1000 },
		{ WaveNumber = 160, GoldReward = 13000, TokensReward = 1100 },
		{ WaveNumber = 170, GoldReward = 15000, TokensReward = 1200 },
		{ WaveNumber = 180, GoldReward = 17500, TokensReward = 1275 },
		{ WaveNumber = 190, GoldReward = 19000, TokensReward = 1300 },
		{ WaveNumber = 200, GoldReward = 25000, TokensReward = 1350 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			CostGold = 100,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_05,
			GainCash = 500,
			GainHP = 100
		},
		{
			WaveNumber = 8,
			CostGold = 300,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 1500,
			GainHP = 300
		},
		{
			WaveNumber = 12,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 2000,
			GainHP = 400
		},
		{
			WaveNumber = 18,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 4500,
			GainHP = 500
		},
		{
			WaveNumber = 25,
			CostGold = 500,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 10000,
			GainHP = 600
		},
		{
			WaveNumber = 30,
			CostGold = 600,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 12500,
			GainHP = 800
		},
		{
			WaveNumber = 35,
			CostGold = 1000,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 16500,
			GainHP = 1200
		},
		{
			WaveNumber = 40,
			CostGold = 1500,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 20000,
			GainHP = 1500
		},
		{
			WaveNumber = 50,
			CostGold = 1700,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 30000,
			GainHP = 1700
		},
		{
			WaveNumber = 60,
			CostGold = 2000,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_65,
			GainCash = 45000,
			GainHP = 2000
		},
		{
			WaveNumber = 70,
			CostGold = 4000,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 60000,
			GainHP = 2500
		},
		{
			WaveNumber = 100,
			CostGold = 6000,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 100000,
			GainHP = 2500
		},
		{
			WaveNumber = 130,
			CostGold = 7500,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 200000,
			GainHP = 5000
		},
		{
			WaveNumber = 150,
			CostGold = 12000,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 300000,
			GainHP = 10000
		},
		{
			WaveNumber = 170,
			CostGold = 25000,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 500000,
			GainHP = 50000
		},
		{
			WaveNumber = 180,
			CostGold = 28000,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 600000,
			GainHP = 300000
		},
		{
			WaveNumber = 190,
			CostGold = 37500,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 1000000,
			GainHP = 750000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			WaveNumber = 20,
			RollCount = 1,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 1,
				[Enums.PowerUps.AC130Support] = 1,
				[Enums.PowerUps.AirStrike] = 1,
				[Enums.PowerUps.RaptorStorm] = 0,
				[Enums.PowerUps.Punkbuster] = 0,
				[Enums.PowerUps.ReconDrone] = 20,
				[Enums.PowerUps.CashCrate] = 15,
				[Enums.PowerUps.HealthCrate] = 30,
				[Enums.PowerUps.HealingField] = 20
			}
		},
		{
			WaveNumber = 30,
			RollCount = 2,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 1,
				[Enums.PowerUps.AC130Support] = 1,
				[Enums.PowerUps.AirStrike] = 1,
				[Enums.PowerUps.RaptorStorm] = 0,
				[Enums.PowerUps.Punkbuster] = 0,
				[Enums.PowerUps.ReconDrone] = 20,
				[Enums.PowerUps.CashCrate] = 15,
				[Enums.PowerUps.HealthCrate] = 30,
				[Enums.PowerUps.HealingField] = 20
			}
		},
		{
			WaveNumber = 40,
			RollCount = 2,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 7,
				[Enums.PowerUps.AC130Support] = 3,
				[Enums.PowerUps.AirStrike] = 20,
				[Enums.PowerUps.RaptorStorm] = 1,
				[Enums.PowerUps.Punkbuster] = 0,
				[Enums.PowerUps.ReconDrone] = 10,
				[Enums.PowerUps.CashCrate] = 15,
				[Enums.PowerUps.HealingField] = 10
			}
		},
		{
			WaveNumber = 50,
			RollCount = 2,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 7,
				[Enums.PowerUps.AC130Support] = 3,
				[Enums.PowerUps.AirStrike] = 15,
				[Enums.PowerUps.RaptorStorm] = 1,
				[Enums.PowerUps.Punkbuster] = 0,
				[Enums.PowerUps.ReconDrone] = 10,
				[Enums.PowerUps.CashCrate] = 15,
				[Enums.PowerUps.HealingField] = 10
			}
		},
		{
			WaveNumber = 60,
			RollCount = 3,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 10,
				[Enums.PowerUps.AC130Support] = 6,
				[Enums.PowerUps.AirStrike] = 22,
				[Enums.PowerUps.RaptorStorm] = 4,
				[Enums.PowerUps.Punkbuster] = 1,
				[Enums.PowerUps.ReconDrone] = 8,
				[Enums.PowerUps.CashCrate] = 10,
				[Enums.PowerUps.HealingField] = 20
			}
		},
		{
			WaveNumber = 70,
			RollCount = 2,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 11,
				[Enums.PowerUps.AC130Support] = 6,
				[Enums.PowerUps.AirStrike] = 25,
				[Enums.PowerUps.RaptorStorm] = 2,
				[Enums.PowerUps.Punkbuster] = 1,
				[Enums.PowerUps.ReconDrone] = 8,
				[Enums.PowerUps.CashCrate] = 10,
				[Enums.PowerUps.HealingField] = 20
			}
		},
		{
			WaveNumber = 80,
			RollCount = 2,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 14,
				[Enums.PowerUps.AC130Support] = 7,
				[Enums.PowerUps.AirStrike] = 30,
				[Enums.PowerUps.RaptorStorm] = 5,
				[Enums.PowerUps.Punkbuster] = 3,
				[Enums.PowerUps.ReconDrone] = 15,
				[Enums.PowerUps.CashCrate] = 5,
				[Enums.PowerUps.HealingField] = 30
			}
		},
		{
			WaveNumber = 80,
			RollCount = 1,
			ChanceTable = { [Enums.PowerUps.Punkbuster] = 1 }
		},
		{
			WaveNumber = 90,
			RollCount = 1,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 15,
				[Enums.PowerUps.AC130Support] = 10,
				[Enums.PowerUps.AirStrike] = 20,
				[Enums.PowerUps.RaptorStorm] = 8,
				[Enums.PowerUps.Punkbuster] = 4,
				[Enums.PowerUps.ReconDrone] = 15,
				[Enums.PowerUps.HealingField] = 10
			}
		},
		{
			WaveNumber = 100,
			RollCount = 1,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 10,
				[Enums.PowerUps.AC130Support] = 8,
				[Enums.PowerUps.AirStrike] = 20,
				[Enums.PowerUps.RaptorStorm] = 7,
				[Enums.PowerUps.Punkbuster] = 4,
				[Enums.PowerUps.NuclearMissile] = 1
			}
		},
		{
			WaveNumber = 100,
			RollCount = 1,
			ChanceTable = { [Enums.PowerUps.AC130Support] = 1 }
		},
		{
			WaveNumber = 100,
			RollCount = 1,
			ChanceTable = { [Enums.PowerUps.RaptorStorm] = 1 }
		},
		{
			WaveNumber = 112,
			RollCount = 1,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 20,
				[Enums.PowerUps.AC130Support] = 10,
				[Enums.PowerUps.AirStrike] = 30,
				[Enums.PowerUps.RaptorStorm] = 7,
				[Enums.PowerUps.Punkbuster] = 4,
				[Enums.PowerUps.NuclearMissile] = 1
			}
		},
		{
			WaveNumber = 130,
			RollCount = 1,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 20,
				[Enums.PowerUps.AC130Support] = 10,
				[Enums.PowerUps.AirStrike] = 40,
				[Enums.PowerUps.RaptorStorm] = 7,
				[Enums.PowerUps.Punkbuster] = 4,
				[Enums.PowerUps.ReconDrone] = 10,
				[Enums.PowerUps.CashCrate] = 5,
				[Enums.PowerUps.HealthCrate] = 0,
				[Enums.PowerUps.HealingField] = 5,
				[Enums.PowerUps.NuclearMissile] = 1
			}
		},
		{
			WaveNumber = 150,
			RollCount = 2,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 20,
				[Enums.PowerUps.AC130Support] = 10,
				[Enums.PowerUps.AirStrike] = 40,
				[Enums.PowerUps.RaptorStorm] = 7,
				[Enums.PowerUps.Punkbuster] = 4,
				[Enums.PowerUps.ReconDrone] = 10,
				[Enums.PowerUps.MOAB] = 5,
				[Enums.PowerUps.HealthCrate] = 0,
				[Enums.PowerUps.HealingField] = 5,
				[Enums.PowerUps.NuclearMissile] = 2
			}
		},
		{
			WaveNumber = 150,
			RollCount = 1,
			ChanceTable = { [Enums.PowerUps.MOAB] = 1 }
		},
		{
			WaveNumber = 170,
			RollCount = 2,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 20,
				[Enums.PowerUps.AC130Support] = 10,
				[Enums.PowerUps.AirStrike] = 40,
				[Enums.PowerUps.RaptorStorm] = 7,
				[Enums.PowerUps.Punkbuster] = 4,
				[Enums.PowerUps.NuclearMissile] = 1
			}
		},
		{
			WaveNumber = 190,
			RollCount = 2,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 20,
				[Enums.PowerUps.AC130Support] = 10,
				[Enums.PowerUps.AirStrike] = 40,
				[Enums.PowerUps.RaptorStorm] = 7,
				[Enums.PowerUps.Punkbuster] = 4,
				[Enums.PowerUps.MOAB] = 5,
				[Enums.PowerUps.NuclearMissile] = 1
			}
		},
		{
			WaveNumber = 200,
			RollCount = 4,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 20,
				[Enums.PowerUps.AC130Support] = 10,
				[Enums.PowerUps.GoldenZed] = 3,
				[Enums.PowerUps.RaptorStorm] = 7,
				[Enums.PowerUps.Punkbuster] = 4,
				[Enums.PowerUps.MOAB] = 5
			}
		},
		{
			WaveNumber = 200,
			RollCount = 1,
			ChanceTable = { [Enums.PowerUps.NuclearMissile] = 1 }
		}
	},
	SkinRewardIntervalMap = {
		{
			WaveNumber = 50,
			SkinName = Enums.Towers.John .. "_Eradicator"
		},
		{
			WaveNumber = 70,
			SkinName = Enums.Towers.Juggernaut .. "_Eradicator"
		},
		{
			WaveNumber = 80,
			SkinName = Enums.Towers.GoldenJuggernaut .. "_Golden Commando"
		}
	},
	DefaultXPPerWavePassed = 125,
	StartingLives = 1000,
	SetUpTime = 15,
	Waves = waves
}
local children = script:GetChildren()
local v = {}
local count = 0

for _, moduleScript in pairs(children) do
	local module = require(moduleScript)

	for k, v2 in pairs(module) do
		if v[k] then
			warn("WaveConfig at index " .. k .. " is already defined")
		else
			v[k] = v2
			count += 1
		end
	end
end

for i = 1, count do
	local v2 = v[i]

	if v2 then
		waves[i] = v2
	else
		warn("WaveConfig at index " .. i .. " is nil")
	end
end

return Endless