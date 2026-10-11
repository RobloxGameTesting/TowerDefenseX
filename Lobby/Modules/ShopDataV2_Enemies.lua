local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local cframe = CFrame.fromEulerAnglesXYZ(0, 2.356194490192345, 0)
local ShopDataV2Enemies = {
	[Enums.Enemies.Arachnina] = {
		Price = 2925,
		PriceInRobux = 80,
		ProductId = 3635359911,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.Boss1] = {
		Price = 925,
		PriceInRobux = 30,
		ProductId = 3635335929,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.Boss2] = {
		Price = 167,
		IsOffsale = true,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.Cloaker] = {
		Price = 167,
		IsOffsale = true,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.Crusher] = {
		Price = 5000,
		PriceInRobux = 135,
		ProductId = 3635384869,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.Disruptor] = {
		Price = 167,
		IsOffsale = true,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.EMP] = {
		Price = 1550,
		PriceInRobux = 50,
		ProductId = 3635344258,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Support,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.Fallout] = {
		Price = 167,
		IsOffsale = true,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Eco,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.FastDroid] = {
		Price = 167,
		IsOffsale = true,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.Flesh] = {
		Price = 625,
		PriceInRobux = 15,
		ProductId = 3635309860,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.Gestalt] = {
		Price = 4500,
		PriceInRobux = 120,
		ProductId = 3635378936,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Offensive,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.HeavyDroid] = {
		Price = 167,
		IsOffsale = true,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Eco,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.HeavyMetal] = {
		Price = 1500,
		PriceInRobux = 55,
		ProductId = 3635341296,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Eco,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.IonGuard] = {
		Price = 2000,
		PriceInRobux = 70,
		ProductId = 3635348583,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.Malfunction] = {
		Price = 750,
		PriceInRobux = 25,
		ProductId = 3635317394,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.NightKnight] = {
		Price = 800,
		PriceInRobux = 25,
		ProductId = 3635331031,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.NormalDroid] = {
		Price = 167,
		IsOffsale = true,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.OverCharge] = {
		Price = 3750,
		PriceInRobux = 110,
		ProductId = 3635373318,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.Sturmtruppler] = {
		Price = 2750,
		PriceInRobux = 75,
		ProductId = 3635354012,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.ToxicWaste2] = {
		Price = 167,
		IsOffsale = true,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.Monstrosity] = {
		Price = 3000,
		PriceInRobux = 100,
		ProductId = 3635366029,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.XJuggernautPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Offensive,
		ViewportRotationOffset = cframe,
		FromBundle = "XenonForcesPVPBundle"
	},
	[Enums.Enemies.ArtemisPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = cframe,
		FromBundle = "XenonForcesPVPBundle"
	},
	[Enums.Enemies.E02PVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Offensive,
		ViewportRotationOffset = cframe,
		FromBundle = "XenonForcesPVPBundle"
	},
	[Enums.Enemies.PhobeusPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = cframe,
		FromBundle = "XenonForcesPVPBundle"
	},
	[Enums.Enemies.TitanChargerPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe,
		FromBundle = "XenonForcesPVPBundle"
	},
	[Enums.Enemies.PurgatoryPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Offensive,
		ViewportRotationOffset = cframe,
		FromBundle = "XenonForcesPVPBundle"
	},
	[Enums.Enemies.JumperPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe,
		FromBundle = "XenonForcesPVPBundle"
	},
	[Enums.Enemies.BuzzardPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe,
		FromBundle = "XenonForcesPVPBundle"
	},
	[Enums.Enemies.HeavyTitanPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe,
		FromBundle = "XenonForcesPVPBundle"
	},
	[Enums.Enemies.PilotPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe,
		FromBundle = "XenonForcesPVPBundle"
	},
	[Enums.Enemies.LavaGolemPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe,
		FromBundle = "PlagueArmyPVPBundle"
	},
	[Enums.Enemies.KnyghtPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe,
		FromBundle = "PlagueArmyPVPBundle"
	},
	[Enums.Enemies.MagePVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Support,
		ViewportRotationOffset = cframe,
		FromBundle = "PlagueArmyPVPBundle"
	},
	[Enums.Enemies.GoldenKnightPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe,
		FromBundle = "PlagueArmyPVPBundle"
	},
	[Enums.Enemies.KingPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = cframe,
		FromBundle = "PlagueArmyPVPBundle"
	},
	[Enums.Enemies.QueenPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = cframe,
		FromBundle = "PlagueArmyPVPBundle"
	},
	[Enums.Enemies.TankKnyghtPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Fodder,
		ViewportRotationOffset = cframe,
		FromBundle = "PlagueArmyPVPBundle"
	},
	[Enums.Enemies.ResurrectedJohnPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Support,
		ViewportRotationOffset = CFrame.fromEulerAnglesXYZ(3.141592653589793, -3.141592653589793, 0),
		FromBundle = "PlagueArmyPVPBundle"
	},
	[Enums.Enemies.BatteringRamPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = cframe,
		FromBundle = "PlagueArmyPVPBundle"
	},
	[Enums.Enemies.ResurrectedSlammerPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Offensive,
		ViewportRotationOffset = cframe,
		FromBundle = "PlagueArmyPVPBundle"
	},
	[Enums.Enemies.EradicatorMKICPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = CFrame.fromEulerAnglesXYZ(0, 0.5235987755982988, 0),
		FromBundle = "HeavyBossesPVPBundle"
	},
	[Enums.Enemies.AlphaPredatorPVP] = {
		Price = 35000,
		PriceInRobux = 1250,
		ProductId = 3635392880,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.EradicatorMK2ReworkPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = CFrame.fromEulerAnglesXYZ(0, 2.0943951023931953, 0),
		FromBundle = "HeavyBossesPVPBundle"
	},
	[Enums.Enemies.DestructorPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = cframe,
		FromBundle = "HeavyBossesPVPBundle"
	},
	[Enums.Enemies.EradicatorMKIPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = cframe,
		FromBundle = "LightBossesPVPBundle"
	},
	[Enums.Enemies.PlagueDoctorPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = cframe,
		FromBundle = "LightBossesPVPBundle"
	},
	[Enums.Enemies.CyberSantaPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = CFrame.fromEulerAnglesXYZ(0, 0, 0),
		FromBundle = "LightBossesPVPBundle"
	},
	[Enums.Enemies.EradBPVP] = {
		Price = 1000000000,
		IsOffsale = true,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = cframe
	},
	[Enums.Enemies.CaptainSlimePVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Boss,
		ViewportRotationOffset = cframe,
		FromBundle = "LightBossesPVPBundle"
	},
	[Enums.Enemies.RangerBot2PVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = CFrame.fromEulerAnglesXYZ(0, 0, 3.6651914291880923),
		FromBundle = "BotsPVPBundle"
	},
	[Enums.Enemies.MissileBotPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe,
		FromBundle = "BotsPVPBundle"
	},
	[Enums.Enemies.OperatorBotPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe,
		FromBundle = "BotsPVPBundle"
	},
	[Enums.Enemies.ScoutBotPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe,
		FromBundle = "BotsPVPBundle"
	},
	[Enums.Enemies.GiantGrenadierBotPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe,
		FromBundle = "BotsPVPBundle"
	},
	[Enums.Enemies.GiantRangerBotPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe,
		FromBundle = "BotsPVPBundle"
	},
	[Enums.Enemies.ShieldBusterPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe,
		FromBundle = "BotsPVPBundle"
	},
	[Enums.Enemies.M1BTankPVP] = {
		Price = 1000000000,
		IsOffsale = false,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Rusher,
		ViewportRotationOffset = cframe,
		FromBundle = "BotsPVPBundle"
	},
	[Enums.Enemies.MultiplierX] = {
		IsOffsale = true,
		Price = 1000000000,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Support
	}
}

if not _G.TB2_EVENT_ENABLED then
	return ShopDataV2Enemies
end

ShopDataV2Enemies[Enums.Enemies.NormalPVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = cframe,
	Subcategory = Enums.ItemSubcategories.Fodder
}
ShopDataV2Enemies[Enums.Enemies.SlowPVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = cframe,
	Subcategory = Enums.ItemSubcategories.Fodder
}
ShopDataV2Enemies[Enums.Enemies.MalignantPVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = cframe,
	Subcategory = Enums.ItemSubcategories.Fodder
}
ShopDataV2Enemies[Enums.Enemies.CystPVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = cframe,
	Subcategory = Enums.ItemSubcategories.Fodder
}
ShopDataV2Enemies[Enums.Enemies.MalicePVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, 0),
	Subcategory = Enums.ItemSubcategories.Fodder
}
ShopDataV2Enemies[Enums.Enemies.VoidWardenPVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = cframe,
	Subcategory = Enums.ItemSubcategories.Fodder
}
ShopDataV2Enemies[Enums.Enemies.VoidPrimePVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = cframe,
	ViewportZoom = 1.3,
	ViewportPositionOffset = vector.create(0, 2, 0),
	Subcategory = Enums.ItemSubcategories.Boss
}
ShopDataV2Enemies[Enums.Enemies.MysteryPVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = cframe,
	Subcategory = Enums.ItemSubcategories.Fodder
}
ShopDataV2Enemies[Enums.Enemies.ShadePVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = cframe,
	Subcategory = Enums.ItemSubcategories.Fodder
}
ShopDataV2Enemies[Enums.Enemies.NosowyPVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = cframe,
	Subcategory = Enums.ItemSubcategories.Fodder
}
ShopDataV2Enemies[Enums.Enemies.MysteryVPVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = cframe,
	Subcategory = Enums.ItemSubcategories.Fodder
}
ShopDataV2Enemies[Enums.Enemies.NeuronPVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = cframe,
	Subcategory = Enums.ItemSubcategories.Fodder
}
ShopDataV2Enemies[Enums.Enemies.CarcinPVP] = {
	IsOffsale = true,
	Price = 1000000000,
	MinLevel = 0,
	ViewportRotationOffset = cframe,
	Subcategory = Enums.ItemSubcategories.Fodder
}
return ShopDataV2Enemies