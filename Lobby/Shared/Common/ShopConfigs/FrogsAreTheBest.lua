local parent = script.Parent.Parent
local Enums = require(parent:WaitForChild("Enums"))
require(parent:WaitForChild("Types"))
local StickerPackNames = Enums.StickerPackNames
local ShopNames = Enums.ShopNames
local ShopRarities = Enums.ShopRarities
return {
	Name = ShopNames.FrogsAreTheBest,
	ShopRarity = ShopRarities.Common,
	NPCName = "Loravocado",
	MaxAvailableInShop = 15,
	ContentRefreshTime = 10,
	TopBarColor = Color3.fromHex("#0076AD"),
	ShopData = {
		[Enums.ShopCategories.StickerPacks] = {
			{
				Name = StickerPackNames.FroggyLovePack,
				Price = 10,
				ProductIdInStock = 12345,
				ProductIdOutOfStock = 12345
			},
			{
				Name = StickerPackNames.FroggyHappyPack,
				Price = 10,
				ProductIdInStock = 12345,
				ProductIdOutOfStock = 12345
			}
		}
	}
}