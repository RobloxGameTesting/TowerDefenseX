local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "April Fools Crate",
	ModelType = "MLGCrate",
	Image = "rbxassetid://116514280210052",
	CanBeOpened = true,
	NoDupes = true,
	Odds = { Common = 73, Uncommon = 20, Epic = 5, Legendary = 2 },
	Skins = {
		{
			Name = "EDJ_Chad",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://95791020045462"
		},
		{
			Name = "Armored Factory_Food",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://81011353750299"
		},
		{
			Name = "XWM Turret_Gamer",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://107940341052411"
		},
		{
			Name = "Golden Ranger_Green Soda",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://99422516191888"
		},
		{
			Name = "Ranger_Dank",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://91450747487938"
		},
		{
			Name = "Sniper_Conspiracy",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://139391610425604"
		},
		{
			Name = "John_Swamp",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://90051851818351"
		},
		{
			Name = "Grenadier_Lenny",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://102035131619402"
		},
		{
			Name = "Scarecrow_Furry",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://75046900285388"
		}
	}
}