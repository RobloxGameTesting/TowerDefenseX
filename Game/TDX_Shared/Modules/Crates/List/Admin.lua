local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	Displayame = "Admin Crate",
	ModelType = "YCrate",
	Image = "rbxassetid://6864920806",
	CanBeOpened = false,
	Odds = { Common = 70, Uncommon = 20, Epic = 9, Legendary = 1 },
	Skins = {
		{ Name = "EDJ_Admin Rockband", Rarity = Enums.SkinRarities.Hidden, Image = "" },
		{ Name = "Operator_HD", Rarity = Enums.SkinRarities.Hidden, Image = "" }
	}
}