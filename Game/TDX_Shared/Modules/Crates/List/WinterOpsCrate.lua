local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "where is this used",
	ModelType = "WinterOpsCrate",
	Image = "rbxassetid://77925522121592",
	CanBeOpened = true,
	NoDupes = true,
	Odds = { Common = 73, Uncommon = 20, Epic = 5, Legendary = 2 },
	Skins = {
		{
			Name = "AA Turret_Winter Ops",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://80559785706282"
		},
		{
			Name = "Golden Ranger_Winter Ops",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://108330727859084"
		},
		{
			Name = "Medic_Winter Ops",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://118282668678994"
		},
		{
			Name = "Golden Mobster_Winter Ops",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://132642374054328"
		},
		{
			Name = "Jet Trooper_Winter Ops",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://125552726470221"
		},
		{
			Name = "Refractor_Winter Ops",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://124793629466890"
		}
	}
}