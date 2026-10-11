local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Valentine's Crate 2",
	ModelType = "ValentinesCrate2",
	ProductId = 3532553247,
	Image = "rbxassetid://75258774965447",
	CanBeOpened = true,
	NoDupes = true,
	Odds = { Common = 73, Uncommon = 20, Epic = 5, Legendary = 2 },
	Skins = {
		{
			Name = "Golden Ranger_Lovely",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://108087981076194"
		},
		{
			Name = "Commander_Melu",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://110877406626872"
		},
		{
			Name = "Slammer_Broken Heart",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://75191724723514"
		},
		{
			Name = "Medic_Real",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://119957072116914"
		}
	}
}