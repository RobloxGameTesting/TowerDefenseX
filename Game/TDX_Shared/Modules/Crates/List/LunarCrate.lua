local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Lunar Crate",
	ModelType = "LunarCrate",
	ProductId = 3538977176,
	Image = "rbxassetid://140627636538398",
	CanBeOpened = true,
	NoDupes = true,
	Odds = { Common = 73, Uncommon = 20, Epic = 5, Legendary = 2 },
	Skins = {
		{
			Name = "Oil Derrick_Lunar",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://125315103030969"
		},
		{
			Name = "Golden Juggernaut_Lunar",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://127269313457957"
		},
		{
			Name = "Behemoth Factory_Overlord",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://111292639444964"
		},
		{
			Name = "Helicopter_Lunar",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://91547909034501"
		}
	}
}