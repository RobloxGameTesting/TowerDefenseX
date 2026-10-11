local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Elite Crate",
	ModelType = "EliteCrate",
	Image = "rbxassetid://131254980247586",
	CanBeOpened = true,
	NoDupes = true,
	Odds = { Common = 73, Uncommon = 20, Epic = 5, Legendary = 2 },
	Skins = {
		{
			Name = "Golden Ranger_Elite",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://76199925857741"
		},
		{
			Name = "Golden Juggernaut_Elite",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://76357635720277"
		},
		{
			Name = "Golden Mine Layer_Elite",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://103081523588245"
		},
		{
			Name = "Patrol Boat_Elite",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://100006667366269"
		},
		{
			Name = "XWM Turret_Elite",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://140192648412087"
		},
		{
			Name = "Slammer_Elite",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://88822810169459"
		},
		{
			Name = "Ghost_Elite",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://86053309262062"
		}
	}
}