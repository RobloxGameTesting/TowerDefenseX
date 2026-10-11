local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Void Crate",
	ModelType = "VoidCrate",
	Image = "",
	CanBeOpened = true,
	NoDupes = true,
	Odds = { Common = 73, Uncommon = 20, Epic = 5, Legendary = 2 },
	Skins = {
		{
			Name = "Commander_Void",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://124700837291863"
		},
		{
			Name = "Golden Juggernaut_Void",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://113675750569325"
		},
		{
			Name = "Slammer_Void",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://133607768363425"
		},
		{
			Name = "Zed_Void",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://110320142845800"
		},
		{
			Name = "Flame Trooper_Umbrix",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://92664991366564"
		},
		{
			Name = "Behemoth Factory_Void",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://114688925181260"
		}
	}
}