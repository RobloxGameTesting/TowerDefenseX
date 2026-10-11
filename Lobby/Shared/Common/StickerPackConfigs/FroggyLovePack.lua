local parent = script.Parent.Parent
local Enums = require(parent:WaitForChild("Enums"))
require(parent:WaitForChild("Types"))
local StickerPackNames = Enums.StickerPackNames
local StickerPackRarities = Enums.StickerPackRarities
local StickerNames = Enums.StickerNames
return {
	Name = StickerPackNames.FroggyLovePack,
	Rarity = StickerPackRarities.Common,
	ShopImage = "rbxassetid://105789781961819",
	ItemImage = "rbxassetid://93290097453126",
	MaxAmountInShop = 30,
	StickerList = { StickerNames.Froggy, StickerNames.FirstDateFrog, StickerNames.FrogInLove }
}