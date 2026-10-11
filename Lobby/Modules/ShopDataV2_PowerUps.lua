local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Enums = require(Common:WaitForChild("Enums"))
local PowerUpsData = require(TDX_Shared.Common.PowerUpsData)
local ShopDataV2PowerUps = {
	[Enums.PowerUps.StrykerRush] = {
		IsRobuxOnly = true,
		LimitedTime = true,
		MinLevel = 0,
		Price = 2100000000,
		Quantity = 1,
		ProductId = 1873670159,
		PriceInRobux = 150,
		QuantityForRobux = 5,
		LayoutOrder = 0
	},
	[Enums.PowerUps.GoldenZed] = {
		IsRobuxOnly = true,
		LimitedTime = true,
		MinLevel = 0,
		Price = 2100000000,
		Quantity = 1,
		ProductId = 1873671070,
		PriceInRobux = 300,
		QuantityForRobux = 1,
		LayoutOrder = 1
	},
	[Enums.PowerUps.VoidCalling] = {
		LimitedTime = true,
		MinLevel = 0,
		Price = 10000,
		Quantity = 1,
		ProductId = 3711193033,
		PriceInRobux = 175,
		QuantityForRobux = 1,
		LayoutOrder = 2
	},
	[Enums.PowerUps.AC130Support] = {
		MinLevel = 0,
		Price = 3500,
		Quantity = 1,
		ProductId = 1810445873,
		PriceInRobux = 325,
		QuantityForRobux = 5,
		LayoutOrder = 15
	},
	[Enums.PowerUps.RaptorStorm] = {
		MinLevel = 0,
		Price = 5000,
		Quantity = 1,
		ProductId = 1810446325,
		PriceInRobux = 450,
		QuantityForRobux = 5,
		LayoutOrder = 20
	},
	[Enums.PowerUps.MOAB] = {
		MinLevel = 0,
		Price = 20000,
		Quantity = 1,
		ProductId = 1866034034,
		PriceInRobux = 250,
		QuantityForRobux = 1,
		LayoutOrder = 25
	},
	[Enums.PowerUps.NuclearMissile] = {
		MinLevel = 0,
		Price = 50000,
		Quantity = 1,
		ProductId = 1816281467,
		PriceInRobux = 1000,
		QuantityForRobux = 1,
		LayoutOrder = 27
	},
	[Enums.PowerUps.ReconDrone] = {
		MinLevel = 0,
		Price = 750,
		Quantity = 1,
		ProductId = 1810446478,
		PriceInRobux = 100,
		QuantityForRobux = 5,
		LayoutOrder = 30
	},
	[Enums.PowerUps.CashCrate] = {
		MinLevel = 0,
		Price = 1000,
		Quantity = 1,
		ProductId = 1810446617,
		PriceInRobux = 125,
		QuantityForRobux = 5,
		LayoutOrder = 35
	},
	[Enums.PowerUps.Punkbuster] = {
		MinLevel = 0,
		Price = 5500,
		Quantity = 1,
		ProductId = 1839010304,
		PriceInRobux = 475,
		QuantityForRobux = 5,
		LayoutOrder = 40
	},
	[Enums.PowerUps.A10Strike] = {
		MinLevel = 0,
		Price = 2000,
		Quantity = 1,
		ProductId = 1810445660,
		PriceInRobux = 225,
		QuantityForRobux = 5,
		LayoutOrder = 41
	},
	[Enums.PowerUps.AirStrike] = {
		MinLevel = 0,
		Price = 1250,
		Quantity = 1,
		ProductId = 1810446026,
		PriceInRobux = 150,
		QuantityForRobux = 5,
		LayoutOrder = 42
	},
	[Enums.PowerUps.B52Bomber] = {
		IsOffsale = true,
		MinLevel = 0,
		Currency = "Burgers",
		Price = 65,
		Quantity = 1,
		ProductId = 3607987909,
		PriceInRobux = 99,
		QuantityForRobux = 1,
		LayoutOrder = 43
	},
	[Enums.PowerUps.HealthCrate] = {
		MinLevel = 0,
		Price = 1000,
		Quantity = 1,
		ProductId = 1810446834,
		PriceInRobux = 125,
		QuantityForRobux = 5,
		LayoutOrder = 45
	},
	[Enums.PowerUps.HealingField] = {
		MinLevel = 0,
		Price = 850,
		Quantity = 1,
		ProductId = 1810447012,
		PriceInRobux = 110,
		QuantityForRobux = 5,
		LayoutOrder = 50
	},
	[Enums.PowerUps.CryoBlast] = {
		IsOffsale = true,
		MinLevel = 0,
		Price = 5000,
		Quantity = 1,
		ProductId = 2677013375,
		PriceInRobux = 250,
		QuantityForRobux = 5,
		LayoutOrder = 51
	},
	[Enums.PowerUps.DropPod] = {
		MinLevel = 0,
		Price = 1750,
		Quantity = 1,
		ProductId = 3245185120,
		PriceInRobux = 185,
		QuantityForRobux = 5,
		LayoutOrder = 10
	},
	[Enums.PowerUps.DamageField] = {
		MinLevel = 0,
		Price = 45,
		Quantity = 1,
		Currency = "Crystals",
		ProductId = 3424365471,
		PriceInRobux = 100,
		QuantityForRobux = 5,
		LayoutOrder = 2
	},
	[Enums.PowerUps.RangeField] = {
		MinLevel = 0,
		Price = 35,
		Quantity = 1,
		Currency = "Crystals",
		ProductId = 3424365839,
		PriceInRobux = 75,
		QuantityForRobux = 5,
		LayoutOrder = 3
	},
	[Enums.PowerUps.UberField] = {
		MinLevel = 0,
		Price = 55,
		Quantity = 1,
		Currency = "Crystals",
		ProductId = 3424366391,
		PriceInRobux = 125,
		QuantityForRobux = 5,
		LayoutOrder = 4
	},
	[Enums.PowerUps.EmergencySupplyCrate] = {
		MinLevel = 0,
		Price = 80,
		Quantity = 1,
		Currency = "Crystals",
		ProductId = 3424366460,
		PriceInRobux = 175,
		QuantityForRobux = 5,
		LayoutOrder = 5
	},
	[Enums.PowerUps.SR71Strike] = {
		MinLevel = 0,
		Price = 105,
		Quantity = 1,
		Currency = "Crystals",
		ProductId = 3424366624,
		PriceInRobux = 225,
		QuantityForRobux = 5,
		LayoutOrder = 6
	},
	[Enums.PowerUps.MegaZed] = {
		IsOffsale = true,
		MinLevel = 0,
		Currency = "Cookies",
		Price = 6,
		Quantity = 1,
		ProductId = 3485898982,
		PriceInRobux = 300,
		QuantityForRobux = 5,
		LayoutOrder = 1
	}
}

if _G.PVP_SHOP_ENABLED then
	ShopDataV2PowerUps[Enums.PowerUps.PVPAirStrike] = {
		PVPOnly = true,
		MinLevel = 0,
		Price = 400,
		Quantity = 5,
		Currency = "Gold",
		ProductId = 3604235626,
		PriceInRobux = 50,
		QuantityForRobux = 5
	}
	ShopDataV2PowerUps[Enums.PowerUps.PVPUberField] = {
		PVPOnly = true,
		MinLevel = 0,
		Price = 200,
		Quantity = 5,
		Currency = "Gold",
		ProductId = 3610304635,
		PriceInRobux = 25,
		QuantityForRobux = 5
	}
	ShopDataV2PowerUps[Enums.PowerUps.PVPRangeBoost] = {
		PVPOnly = true,
		MinLevel = 0,
		Price = 200,
		Quantity = 5,
		Currency = "Gold",
		ProductId = 3610304703,
		PriceInRobux = 25,
		QuantityForRobux = 5
	}
	ShopDataV2PowerUps[Enums.PowerUps.PVPGlobalDamageMode] = {
		PVPOnly = true,
		MinLevel = 0,
		Price = 200,
		Quantity = 5,
		Currency = "Gold",
		ProductId = 3610304725,
		PriceInRobux = 25,
		QuantityForRobux = 5
	}
	ShopDataV2PowerUps[Enums.PowerUps.PVPEcoBoost] = {
		PVPOnly = true,
		IsOffsale = true,
		MinLevel = 0,
		Price = 75,
		Quantity = 5,
		Currency = "Gold",
		ProductId = 3610304751,
		PriceInRobux = 10,
		QuantityForRobux = 5
	}
	ShopDataV2PowerUps[Enums.PowerUps.PVPEnemySpeedBoost] = {
		PVPOnly = true,
		MinLevel = 0,
		Price = 200,
		Quantity = 5,
		Currency = "Gold",
		ProductId = 3610304762,
		PriceInRobux = 25,
		QuantityForRobux = 5
	}
	ShopDataV2PowerUps[Enums.PowerUps.PVPEnemyShieldRegen] = {
		PVPOnly = true,
		MinLevel = 0,
		Price = 200,
		Quantity = 5,
		Currency = "Gold",
		ProductId = 3610304780,
		PriceInRobux = 25,
		QuantityForRobux = 5
	}
end

for k, v in PowerUpsData do
	if ShopDataV2PowerUps[k] then
		ShopDataV2PowerUps[k].Image = v.MainImage
	end
end

return ShopDataV2PowerUps