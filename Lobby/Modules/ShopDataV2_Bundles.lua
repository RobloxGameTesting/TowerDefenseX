local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	ChristmasBundle = {
		IsOffsale = true,
		Image = "rbxassetid://127970105009943",
		PriceInRobux = 400,
		Price = 0,
		MinLevel = 0,
		IsRobuxOnly = true,
		ProductId = 2677014753,
		Contents = {
			Skins = {
				Enums.Towers.MineLayer .. "_Christmas",
				Enums.Towers.Operator .. "_Christmas",
				Enums.Towers.Ranger .. "_Christmas",
				Enums.Towers.LaserGunner .. "_Christmas",
				Enums.Towers.Farm .. "_Christmas",
				Enums.Towers.PatrolBoat .. "_Christmas"
			}
		}
	},
	ValentinesBundle = {
		IsOffsale = true,
		LimitedTime = true,
		Image = "rbxassetid://16370347266",
		PriceInRobux = 455,
		Price = 0,
		MinLevel = 0,
		IsRobuxOnly = true,
		ProductId = 1754498436,
		Contents = {
			Skins = {
				Enums.Towers.John .. "_Valentine's",
				Enums.Towers.Sniper .. "_Valentine's",
				Enums.Towers.Railgunner .. "_Valentine's",
				Enums.Towers.Operator .. "_Valentine's",
				Enums.Towers.Grenadier .. "_Valentine's",
				Enums.Towers.MineLayer .. "_Valentine's",
				Enums.Towers.MissileTrooper .. "_Valentine's",
				Enums.Towers.EDJ .. "_Valentine's"
			}
		}
	},
	XenonForcesPVPBundle = {
		PVPOnly = true,
		Price = 13000,
		PriceInRobux = 455,
		ProductId = 3635473328,
		Currency = "Gold",
		MinLevel = 0,
		Image = "rbxassetid://123597754440263",
		Contents = {
			Enemies = {
				Enums.Enemies.XJuggernautPVP,
				Enums.Enemies.E02PVP,
				Enums.Enemies.ArtemisPVP,
				Enums.Enemies.PhobeusPVP,
				Enums.Enemies.TitanChargerPVP,
				Enums.Enemies.PurgatoryPVP,
				Enums.Enemies.JumperPVP,
				Enums.Enemies.BuzzardPVP,
				Enums.Enemies.HeavyTitanPVP,
				Enums.Enemies.PilotPVP
			}
		},
		LayoutOrder = 1
	},
	PlagueArmyPVPBundle = {
		PVPOnly = true,
		Price = 12500,
		PriceInRobux = 425,
		ProductId = 3635476334,
		Currency = "Gold",
		MinLevel = 0,
		Image = "rbxassetid://101800543339001",
		Contents = {
			Enemies = {
				Enums.Enemies.LavaGolemPVP,
				Enums.Enemies.KnyghtPVP,
				Enums.Enemies.MagePVP,
				Enums.Enemies.GoldenKnightPVP,
				Enums.Enemies.KingPVP,
				Enums.Enemies.QueenPVP,
				Enums.Enemies.TankKnyghtPVP,
				Enums.Enemies.ResurrectedJohnPVP,
				Enums.Enemies.BatteringRamPVP,
				Enums.Enemies.ResurrectedSlammerPVP
			}
		},
		LayoutOrder = 2
	},
	LightBossesPVPBundle = {
		PVPOnly = true,
		Price = 14000,
		PriceInRobux = 475,
		ProductId = 3635478779,
		Currency = "Gold",
		MinLevel = 0,
		Image = "rbxassetid://115572653429086",
		Contents = {
			Enemies = {
				Enums.Enemies.EradicatorMKIPVP,
				Enums.Enemies.PlagueDoctorPVP,
				Enums.Enemies.CyberSantaPVP,
				Enums.Enemies.CaptainSlimePVP
			}
		},
		LayoutOrder = 3
	},
	HeavyBossesPVPBundle = {
		PVPOnly = true,
		Price = 30000,
		PriceInRobux = 800,
		ProductId = 3635481220,
		Currency = "Gold",
		MinLevel = 0,
		Image = "rbxassetid://70684618220553",
		Contents = {
			Enemies = {
				Enums.Enemies.EradicatorMKICPVP,
				Enums.Enemies.EradicatorMK2ReworkPVP,
				Enums.Enemies.DestructorPVP
			}
		},
		LayoutOrder = 4
	},
	BotsPVPBundle = {
		PVPOnly = true,
		Price = 12750,
		PriceInRobux = 450,
		ProductId = 3635484582,
		Currency = "Gold",
		MinLevel = 0,
		Image = "rbxassetid://88743629303774",
		Contents = {
			Enemies = {
				Enums.Enemies.RangerBot2PVP,
				Enums.Enemies.MissileBotPVP,
				Enums.Enemies.OperatorBotPVP,
				Enums.Enemies.ScoutBotPVP,
				Enums.Enemies.GiantGrenadierBotPVP,
				Enums.Enemies.GiantRangerBotPVP,
				Enums.Enemies.ShieldBusterPVP,
				Enums.Enemies.M1BTankPVP
			}
		},
		LayoutOrder = 5
	}
}