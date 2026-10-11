local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "1 Year Party Crate",
	ModelType = "PartyCrate",
	Image = "rbxassetid://85144494716581",
	CanBeOpened = true,
	NoDupes = true,
	Odds = { Common = 73, Uncommon = 20, Epic = 5, Legendary = 2 },
	Skins = {
		{
			Name = "John_Party",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://131700768603193"
		},
		{
			Name = "Ranger_Party",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://100912980895936"
		},
		{
			Name = "Missile Trooper_Party",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://106918267220899"
		},
		{
			Name = "Farm_Party",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://76158638453139"
		},
		{
			Name = "Juggernaut_Party",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://77800412548368"
		},
		{
			Name = "Artillery_Party",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://121939714182315"
		}
	}
}