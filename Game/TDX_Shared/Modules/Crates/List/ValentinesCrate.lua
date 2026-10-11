local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.CrateTypes)
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Valentine's Crate",
	ProductId = 2969684483,
	ModelType = "ValentinesCrate",
	Image = "rbxassetid://139665335055289",
	CanBeOpened = true,
	NoDupes = true,
	Odds = { Common = 73, Uncommon = 20, Epic = 5, Legendary = 2 },
	Skins = {
		{
			Name = "Mine Layer_Cat Maid",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://114132938045273"
		},
		{
			Name = "John_Anime",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://121990995468440"
		},
		{
			Name = "John_Neko",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://99219605015251"
		},
		{
			Name = "Missile Trooper_Neko",
			Rarity = Enums.SkinRarities.Uncommon,
			Image = "rbxassetid://116550037074324"
		},
		{
			Name = "Farm_Neko",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://99964201753387"
		},
		{
			Name = "Shotgunner_Anime",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://111518185868802"
		},
		{
			Name = "Armored Factory_Anime",
			Rarity = Enums.SkinRarities.Legendary,
			Image = "rbxassetid://95670823271146"
		},
		{
			Name = "Grenadier_Lovable",
			Rarity = Enums.SkinRarities.Common,
			Image = "rbxassetid://120176140230672"
		},
		{
			Name = "Sentry_Anime",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://103621046969211"
		},
		{
			Name = "Juggernaut_Cat Girl",
			Rarity = Enums.SkinRarities.Epic,
			Image = "rbxassetid://134650559112540"
		}
	}
}