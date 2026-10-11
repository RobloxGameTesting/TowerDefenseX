local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Summer Crate",
	ModelType = "SummerCrate",
	Image = "",
	CanBeOpened = true,
	NoDupes = true,
	Odds = { Common = 73, Uncommon = 20, Epic = 5, Legendary = 2 },
	Skins = {
		{
			Name = "Mine Layer_Summer",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://93480284873583"
		},
		{
			Name = "Slammer_Summer",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://118951325138256"
		},
		{
			Name = "Operator_Summer",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://111284886909284"
		},
		{
			Name = "Medic_Summer",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://135960538433626"
		},
		{
			Name = "Grenadier_Summer",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://94124666873269"
		},
		{
			Name = "John_Summer",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://101377121378268"
		},
		{
			Name = "Missile Trooper_Summer",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://137905812711397"
		},
		{
			Name = "EDJ_Summer",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://96336243706389"
		},
		{
			Name = "XWM Turret_Summer",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://125825032635827"
		}
	}
}