local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "July Crate",
	ModelType = "JulyCrate",
	Image = "rbxassetid://18335816213",
	CanBeOpened = true,
	NoDupes = true,
	Odds = { Common = 73, Uncommon = 20, Epic = 5, Legendary = 2 },
	Skins = {
		{
			Name = "Helicopter_USA",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://73930958867523"
		},
		{
			Name = "AA Turret_USA",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://119012259899591"
		},
		{
			Name = "John_Burger",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://137794786275463"
		},
		{
			Name = "Ghost_Cowboy",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://98187582522340"
		},
		{
			Name = "Juggernaut_Bulldozer",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://18324678133"
		},
		{
			Name = "Ranger_Freedom",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://18335277351"
		},
		{
			Name = "John_Cowboy",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://18324757675"
		},
		{
			Name = "Medic_Combat",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://18324629140"
		},
		{
			Name = "Warship_United",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://18328025233"
		},
		{
			Name = "Armored Factory_Patriot",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://18328300574"
		},
		{
			Name = "Grenadier_U.S.",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://18335308936"
		},
		{
			Name = "Missile Trooper_Soldier",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://18324730993"
		},
		{
			Name = "Slammer_Miss America",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://18335249773"
		},
		{
			Name = "Railgunner_Freedom Beam",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://18335423504"
		}
	}
}