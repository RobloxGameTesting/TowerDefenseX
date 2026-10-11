local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "PVP Crate",
	ModelType = "PVPCrate",
	Image = "rbxassetid://113805085877090",
	CanBeOpened = true,
	NoDupes = true,
	Odds = { Common = 73, Uncommon = 20, Epic = 5, Legendary = 2 },
	Skins = {
		{ Name = "Juggernaut_PVP", Rarity = Enums.SkinRarities.Uncommon, Image = "" },
		{ Name = "Grenadier_PVP", Rarity = Enums.SkinRarities.Common, Image = "" }
	}
}